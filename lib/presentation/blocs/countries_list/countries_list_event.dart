part of 'countries_list_bloc.dart';

abstract class CountriesListEvent extends Equatable {
  const CountriesListEvent();

  @override
  List<Object> get props => [];
}

class FetchCountriesListEvent extends CountriesListEvent {}

class SearchCountriesEvent extends CountriesListEvent {
  final String query;

  const SearchCountriesEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class RefreshCountriesListEvent extends CountriesListEvent {}
