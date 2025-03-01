part of 'country_details_bloc.dart';

abstract class CountryDetailsEvent extends Equatable {
  const CountryDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchCountryDetailsEvent extends CountryDetailsEvent {
  final String name;

  const FetchCountryDetailsEvent({required this.name});

  @override
  List<Object> get props => [name];
}
