import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/country.dart';
import '../../domain/repositories/country_repository.dart';
import '../datasources/country_local_data_source.dart';
import '../datasources/country_remote_data_source.dart';

class CountryRepositoryImpl implements CountryRepository {
  final CountryRemoteDataSource remoteDataSource;
  final CountryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CountryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Country>>> getAfricanCountries() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCountries = await remoteDataSource.getAfricanCountries();
        await localDataSource.cacheAfricanCountries(remoteCountries);
        return Right(remoteCountries);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localCountries =
            await localDataSource.getCachedAfricanCountries();
        return Right(localCountries);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, CountryDetails>> getCountryDetails(String name) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCountryDetails =
            await remoteDataSource.getCountryDetails(name);
        await localDataSource.cacheCountryDetails(remoteCountryDetails);
        return Right(remoteCountryDetails);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localCountryDetails =
            await localDataSource.getCachedCountryDetails(name);
        return Right(localCountryDetails);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }
}
