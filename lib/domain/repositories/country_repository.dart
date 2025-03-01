import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/country.dart';

abstract class CountryRepository {
  Future<Either<Failure, List<Country>>> getAfricanCountries();

  Future<Either<Failure, CountryDetails>> getCountryDetails(String name);
}
