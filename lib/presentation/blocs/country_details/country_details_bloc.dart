import 'package:cubex/domain/entities/country.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_country_details.dart';

part 'country_details_event.dart';
part 'country_details_state.dart';

class CountryDetailsBloc
    extends Bloc<CountryDetailsEvent, CountryDetailsState> {
  final GetCountryDetails getCountryDetails;

  CountryDetailsBloc({
    required this.getCountryDetails,
  }) : super(CountryDetailsInitial()) {
    on<FetchCountryDetailsEvent>(_onFetchCountryDetails);
  }

  Future<void> _onFetchCountryDetails(
    FetchCountryDetailsEvent event,
    Emitter<CountryDetailsState> emit,
  ) async {
    emit(CountryDetailsLoading());

    final result = await getCountryDetails(CountryParams(name: event.name));

    result.fold(
      (failure) => emit(CountryDetailsError(message: failure.message)),
      (countryDetails) =>
          emit(CountryDetailsLoaded(countryDetails: countryDetails)),
    );
  }
}
