import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io' show Platform;

import '../../../core/di/injection_container.dart';
import '../../blocs/countries_list/countries_list_bloc.dart';
import '../../widgets/adaptive_app_bar.dart';
import '../../widgets/country_card.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/search_bar_widget.dart';
import '../../widgets/shimmer_loading.dart';
import '../details/country_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  late CountriesListBloc _countriesListBloc;

  @override
  void initState() {
    super.initState();
    _countriesListBloc = sl<CountriesListBloc>();
    _countriesListBloc.add(FetchCountriesListEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _countriesListBloc,
      child: Platform.isIOS ? _buildCupertinoPage() : _buildMaterialPage(),
    );
  }

  Widget _buildMaterialPage() {
    return Scaffold(
      appBar: const AdaptiveAppBar(
        title: 'African Countries',
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _buildCountriesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCupertinoPage() {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('African Countries'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(),
            Expanded(
              child: _buildCountriesList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return BlocBuilder<CountriesListBloc, CountriesListState>(
      buildWhen: (previous, current) =>
          current is CountriesListLoaded &&
          (previous is! CountriesListLoaded ||
              previous.searchQuery != current.searchQuery),
      builder: (context, state) {
        if (state is CountriesListLoaded && state.searchQuery.isNotEmpty) {
          _searchController.text = state.searchQuery;
          _searchController.selection = TextSelection.fromPosition(
            TextPosition(offset: _searchController.text.length),
          );
        }

        return SearchBarWidget(
          hint: 'Search countries...',
          controller: _searchController,
          onChanged: (query) {
            context
                .read<CountriesListBloc>()
                .add(SearchCountriesEvent(query: query));
          },
          onClear: () {
            context
                .read<CountriesListBloc>()
                .add(const SearchCountriesEvent(query: ''));
          },
        );
      },
    );
  }

  Widget _buildCountriesList() {
    return BlocBuilder<CountriesListBloc, CountriesListState>(
      builder: (context, state) {
        if (state is CountriesListInitial || state is CountriesListLoading) {
          return const ShimmerCountryList();
        } else if (state is CountriesListLoaded) {
          if (state.filteredCountries.isEmpty) {
            return _buildEmptyState(state.searchQuery.isEmpty
                ? 'No countries found.'
                : 'No countries matching "${state.searchQuery}".');
          }

          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<CountriesListBloc>()
                  .add(RefreshCountriesListEvent());
            },
            child: ListView.builder(
              itemCount: state.filteredCountries.length,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemBuilder: (context, index) {
                final country = state.filteredCountries[index];
                return CountryCard(
                  country: country,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CountryDetailsPage(
                          countryName: country.name,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        } else if (state is CountriesListError) {
          return ErrorDisplayWidget(
            message: state.message,
            onRetry: () {
              context.read<CountriesListBloc>().add(FetchCountriesListEvent());
            },
          );
        }

        return const Center(child: Text('Something went wrong.'));
      },
    );
  }

  Widget _buildEmptyState(String message) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: theme.colorScheme.primary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            if (_searchController.text.isNotEmpty) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  _searchController.clear();
                  context.read<CountriesListBloc>().add(
                        const SearchCountriesEvent(query: ''),
                      );
                },
                child: const Text('Clear Search'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
