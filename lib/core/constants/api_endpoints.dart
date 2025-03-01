class ApiEndpoints {
  static const String baseUrl = 'https://restcountries.com/v3.1';

  static const String africanCountries =
      '$baseUrl/region/africa?status=true&fields=name,languages,capital,flags';

  static String countryByName(String name) => '$baseUrl/name/$name';
}
