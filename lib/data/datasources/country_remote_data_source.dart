import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/constants/api_endpoints.dart';
import '../../core/errors/exceptions.dart';
import '../models/country_model.dart';
import '../models/country_details_model.dart';

abstract class CountryRemoteDataSource {
  /// Throws [ServerException] if there's an error
  Future<List<CountryModel>> getAfricanCountries();

  /// Throws [ServerException] if there's an error
  Future<CountryDetailsModel> getCountryDetails(String name);
}

class CountryRemoteDataSourceImpl implements CountryRemoteDataSource {
  final http.Client client;

  CountryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CountryModel>> getAfricanCountries() async {
    try {
      final response = await client.get(
        Uri.parse(ApiEndpoints.africanCountries),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData
            .map((countryJson) => CountryModel.fromJson(countryJson))
            .toList();
      } else {
        throw ServerException(
          message: 'Failed to fetch African countries',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<CountryDetailsModel> getCountryDetails(String name) async {
    try {
      final response = await client.get(
        Uri.parse(ApiEndpoints.countryByName(name)),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        // im taking the first result as the API might return multiple results
        // for countries with similar names
        return CountryDetailsModel.fromJson(jsonData.first);
      } else {
        throw ServerException(
          message: 'Failed to fetch details for $name',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }
}
