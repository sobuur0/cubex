import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/errors/failures.dart';
import '../entities/country.dart';
import '../repositories/country_repository.dart';

class GetCountryDetails {
  final CountryRepository repository;

  GetCountryDetails({required this.repository});

  Future<Either<Failure, CountryDetails>> call(CountryParams params) async {
    return await repository.getCountryDetails(params.name);
  }
}

class CountryParams extends Equatable {
  final String name;

  const CountryParams({required this.name});

  @override
  List<Object?> get props => [name];
}
