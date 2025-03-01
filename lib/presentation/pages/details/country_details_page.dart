import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io' show Platform;
import 'package:intl/intl.dart';

import '../../../core/di/injection_container.dart';
import '../../../domain/entities/country.dart';
import '../../blocs/country_details/country_details_bloc.dart';
import '../../widgets/adaptive_app_bar.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/shimmer_loading.dart';

class CountryDetailsPage extends StatefulWidget {
  final String countryName;

  const CountryDetailsPage({
    super.key,
    required this.countryName,
  });

  @override
  State<CountryDetailsPage> createState() => _CountryDetailsPageState();
}

class _CountryDetailsPageState extends State<CountryDetailsPage> {
  late CountryDetailsBloc _countryDetailsBloc;

  @override
  void initState() {
    super.initState();
    _countryDetailsBloc = sl<CountryDetailsBloc>();
    _countryDetailsBloc.add(FetchCountryDetailsEvent(name: widget.countryName));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _countryDetailsBloc,
      child: Platform.isIOS ? _buildCupertinoPage() : _buildMaterialPage(),
    );
  }

  Widget _buildMaterialPage() {
    return Scaffold(
      appBar: AdaptiveAppBar(
        title: widget.countryName,
      ),
      body: _buildContent(),
    );
  }

  Widget _buildCupertinoPage() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.countryName),
      ),
      child: SafeArea(
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return BlocBuilder<CountryDetailsBloc, CountryDetailsState>(
      builder: (context, state) {
        if (state is CountryDetailsInitial || state is CountryDetailsLoading) {
          return const ShimmerCountryDetails();
        } else if (state is CountryDetailsLoaded) {
          return _buildCountryDetails(state.countryDetails);
        } else if (state is CountryDetailsError) {
          return ErrorDisplayWidget(
            message: state.message,
            onRetry: () {
              context.read<CountryDetailsBloc>().add(
                    FetchCountryDetailsEvent(name: widget.countryName),
                  );
            },
          );
        }
        return const Center(child: Text('Something went wrong.'));
      },
    );
  }

  Widget _buildCountryDetails(CountryDetails country) {
    final theme = Theme.of(context);
    final numberFormat = NumberFormat('#,###');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Hero(
              tag: 'country_flag_${country.name}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: country.flagUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: theme.colorScheme.surface,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: theme.colorScheme.errorContainer,
                    width: double.infinity,
                    height: 200,
                    child: Center(
                      child: Icon(
                        Icons.broken_image,
                        color: theme.colorScheme.error,
                        size: 48,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            country.name,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          Text(
            country.officialName,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.secondary,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 24),
          _buildInfoSection(
            title: 'Basic Information',
            children: [
              _buildInfoRow(
                label: 'Region',
                value: '${country.region} (${country.subregion})',
                icon: Icons.public,
                theme: theme,
              ),
              _buildInfoRow(
                label: 'Capital',
                value: country.capitals.isNotEmpty
                    ? country.capitals.join(', ')
                    : 'N/A',
                icon: Icons.location_city,
                theme: theme,
              ),
              _buildInfoRow(
                label: 'Population',
                value: numberFormat.format(country.population),
                icon: Icons.people,
                theme: theme,
              ),
              _buildInfoRow(
                label: 'Area',
                value: '${numberFormat.format(country.area)} km²',
                icon: Icons.crop_square,
                theme: theme,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoSection(
            title: 'Language & Culture',
            children: [
              _buildInfoRow(
                label: 'Languages',
                value: country.languages.isEmpty
                    ? 'N/A'
                    : country.languages.values.join(', '),
                icon: Icons.language,
                theme: theme,
              ),
              _buildInfoRow(
                label: 'Currencies',
                value: country.currencies.isEmpty
                    ? 'N/A'
                    : country.currencies.join(', '),
                icon: Icons.attach_money,
                theme: theme,
              ),
              if (country.gini != null)
                _buildInfoRow(
                  label: 'Gini Index',
                  value: '${country.gini}',
                  icon: Icons.equalizer,
                  theme: theme,
                ),
              _buildInfoRow(
                label: 'Start of Week',
                value: country.startOfWeek.capitalizeFirst(),
                icon: Icons.calendar_today,
                theme: theme,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoSection(
            title: 'Location & Borders',
            children: [
              _buildInfoRow(
                label: 'Timezones',
                value: country.timezones.join(', '),
                icon: Icons.access_time,
                theme: theme,
              ),
              _buildInfoRow(
                label: 'Bordering Countries',
                value: country.borders.isEmpty
                    ? 'None (Island nation or no land borders)'
                    : country.borders.join(', '),
                icon: Icons.map,
                theme: theme,
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (country.maps.containsKey('googleMaps')) ...[
            Card(
              margin: EdgeInsets.zero,
              child: ListTile(
                title: Text(
                  'View on Google Maps',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Icon(
                  Icons.map_outlined,
                  color: theme.colorScheme.primary,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: theme.colorScheme.primary,
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Opening Google Maps link for ${country.name}'),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          elevation: 1,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: children,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required String label,
    required String value,
    required IconData icon,
    required ThemeData theme,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalizeFirst() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
