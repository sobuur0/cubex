part of 'country_details_bloc.dart';

abstract class CountryDetailsState extends Equatable {
  const CountryDetailsState();

  @override
  List<Object> get props => [];
}

class CountryDetailsInitial extends CountryDetailsState {}

class CountryDetailsLoading extends CountryDetailsState {}

class CountryDetailsLoaded extends CountryDetailsState {
  final CountryDetails countryDetails;

  const CountryDetailsLoaded({required this.countryDetails});

  @override
  List<Object> get props => [countryDetails];
}

class CountryDetailsError extends CountryDetailsState {
  final String message;

  const CountryDetailsError({required this.message});

  @override
  List<Object> get props => [message];
}
