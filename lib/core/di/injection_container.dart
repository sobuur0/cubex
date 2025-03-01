import 'package:cubex/data/datasources/country_local_data_source.dart';
import 'package:cubex/data/datasources/country_remote_data_source.dart';
import 'package:cubex/data/repositories/country_repository_impl.dart';
import 'package:cubex/domain/repositories/country_repository.dart';
import 'package:cubex/domain/usecases/get_african_countries.dart';
import 'package:cubex/domain/usecases/get_country_details.dart';
import 'package:cubex/presentation/blocs/country_details/country_details_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../presentation/blocs/countries_list/countries_list_bloc.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => CountriesListBloc(getAfricanCountries: sl()),
  );

  sl.registerFactory(
    () => CountryDetailsBloc(getCountryDetails: sl()),
  );

  sl.registerLazySingleton(() => GetAfricanCountries(repository: sl()));
  sl.registerLazySingleton(() => GetCountryDetails(repository: sl()));

  sl.registerLazySingleton<CountryRepository>(
    () => CountryRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<CountryRemoteDataSource>(
    () => CountryRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<CountryLocalDataSource>(
    () => CountryLocalDataSourceImpl(
      countriesBox: sl<Box>(instanceName: 'countries_box'),
      countryDetailsBox: sl<Box>(instanceName: 'country_details_box'),
    ),
  );

  final countriesBox = await Hive.openBox('countries_box');
  final countryDetailsBox = await Hive.openBox('country_details_box');

  sl.registerLazySingleton<Box>(
    () => countriesBox,
    instanceName: 'countries_box',
  );

  sl.registerLazySingleton<Box>(
    () => countryDetailsBox,
    instanceName: 'country_details_box',
  );

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: sl()),
  );

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
