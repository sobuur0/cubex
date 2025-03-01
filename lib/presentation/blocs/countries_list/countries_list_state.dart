part of 'countries_list_bloc.dart';

abstract class CountriesListState extends Equatable {
  const CountriesListState();

  @override
  List<Object> get props => [];
}

class CountriesListInitial extends CountriesListState {}

class CountriesListLoading extends CountriesListState {}

class CountriesListLoaded extends CountriesListState {
  final List<Country> allCountries;
  final List<Country> filteredCountries;
  final String searchQuery;

  const CountriesListLoaded({
    required this.allCountries,
    required this.filteredCountries,
    this.searchQuery = '',
  });

  @override
  List<Object> get props => [allCountries, filteredCountries, searchQuery];
}

class CountriesListError extends CountriesListState {
  final String message;

  const CountriesListError({required this.message});

  @override
  List<Object> get props => [message];
}
