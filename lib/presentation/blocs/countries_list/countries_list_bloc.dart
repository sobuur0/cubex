import 'package:cubex/domain/entities/country.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_african_countries.dart';

part 'countries_list_event.dart';
part 'countries_list_state.dart';

class CountriesListBloc extends Bloc<CountriesListEvent, CountriesListState> {
  final GetAfricanCountries getAfricanCountries;

  CountriesListBloc({
    required this.getAfricanCountries,
  }) : super(CountriesListInitial()) {
    on<FetchCountriesListEvent>(_onFetchCountriesList);
    on<SearchCountriesEvent>(_onSearchCountries);
    on<RefreshCountriesListEvent>(_onRefreshCountriesList);
  }

  Future<void> _onFetchCountriesList(
    FetchCountriesListEvent event,
    Emitter<CountriesListState> emit,
  ) async {
    emit(CountriesListLoading());

    final result = await getAfricanCountries(NoParams());

    result.fold(
      (failure) => emit(CountriesListError(message: failure.message)),
      (countries) {
        emit(CountriesListLoaded(
          allCountries: countries,
          filteredCountries: countries,
        ));
      },
    );
  }

  Future<void> _onSearchCountries(
    SearchCountriesEvent event,
    Emitter<CountriesListState> emit,
  ) async {
    if (state is CountriesListLoaded) {
      final currentState = state as CountriesListLoaded;

      if (event.query.isEmpty) {
        emit(CountriesListLoaded(
          allCountries: currentState.allCountries,
          filteredCountries: currentState.allCountries,
          searchQuery: '',
        ));
      } else {
        final filteredCountries = currentState.allCountries.where((country) {
          return country.name.toLowerCase().contains(event.query.toLowerCase());
        }).toList();

        emit(CountriesListLoaded(
          allCountries: currentState.allCountries,
          filteredCountries: filteredCountries,
          searchQuery: event.query,
        ));
      }
    }
  }

  Future<void> _onRefreshCountriesList(
    RefreshCountriesListEvent event,
    Emitter<CountriesListState> emit,
  ) async {
    final result = await getAfricanCountries(NoParams());

    result.fold(
      (failure) => emit(CountriesListError(message: failure.message)),
      (countries) {
        emit(CountriesListLoaded(
          allCountries: countries,
          filteredCountries: countries,
        ));
      },
    );
  }
}
