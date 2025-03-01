import 'dart:convert';
import 'package:hive/hive.dart';

import '../../core/errors/exceptions.dart';
import '../models/country_model.dart';
import '../models/country_details_model.dart';

abstract class CountryLocalDataSource {
  /// Throws [CacheException] if no cached data is present
  Future<List<CountryModel>> getCachedAfricanCountries();

  Future<void> cacheAfricanCountries(List<CountryModel> countries);

  /// Throws [CacheException] if no cached data is present
  Future<CountryDetailsModel> getCachedCountryDetails(String name);

  Future<void> cacheCountryDetails(CountryDetailsModel countryDetails);
}

class CountryLocalDataSourceImpl implements CountryLocalDataSource {
  final Box countriesBox;
  final Box countryDetailsBox;

  static const String countriesKey = 'AFRICAN_COUNTRIES';

  CountryLocalDataSourceImpl({
    required this.countriesBox,
    required this.countryDetailsBox,
  });

  @override
  Future<List<CountryModel>> getCachedAfricanCountries() async {
    try {
      if (!countriesBox.containsKey(countriesKey)) {
        throw CacheException(message: 'No cached African countries found');
      }

      final jsonData = json.decode(countriesBox.get(countriesKey)) as List;
      return jsonData
          .map((countryJson) => CountryModel.fromJson(countryJson))
          .toList();
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<void> cacheAfricanCountries(List<CountryModel> countries) async {
    try {
      final jsonList = countries.map((country) => country.toJson()).toList();
      await countriesBox.put(countriesKey, json.encode(jsonList));
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<CountryDetailsModel> getCachedCountryDetails(String name) async {
    try {
      if (!countryDetailsBox.containsKey(name)) {
        throw CacheException(message: 'No cached details found for $name');
      }

      final jsonData = json.decode(countryDetailsBox.get(name));
      return CountryDetailsModel.fromJson(jsonData);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<void> cacheCountryDetails(CountryDetailsModel countryDetails) async {
    try {
      await countryDetailsBox.put(
        countryDetails.name,
        json.encode(countryDetails.toJson()),
      );
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
