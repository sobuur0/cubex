import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/errors/failures.dart';
import '../entities/country.dart';
import '../repositories/country_repository.dart';

class GetAfricanCountries {
  final CountryRepository repository;

  GetAfricanCountries({required this.repository});

  Future<Either<Failure, List<Country>>> call(NoParams params) async {
    return await repository.getAfricanCountries();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
