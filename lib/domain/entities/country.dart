import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String name;
  final List<String> capitals;
  final Map<String, String> languages;
  final String flagUrl;
  final String flagEmoji;

  const Country({
    required this.name,
    required this.capitals,
    required this.languages,
    required this.flagUrl,
    required this.flagEmoji,
  });

  @override
  List<Object?> get props => [name, capitals, languages, flagUrl, flagEmoji];
}

class CountryDetails extends Equatable {
  final String name;
  final String officialName;
  final List<String> capitals;
  final Map<String, String> languages;
  final String flagUrl;
  final String flagEmoji;
  final String region;
  final String subregion;
  final int population;
  final List<String> currencies;
  final List<String> timezones;
  final double area;
  final Map<String, dynamic> maps;
  final int? gini;
  final List<String> borders;
  final String startOfWeek;

  const CountryDetails({
    required this.name,
    required this.officialName,
    required this.capitals,
    required this.languages,
    required this.flagUrl,
    required this.flagEmoji,
    required this.region,
    required this.subregion,
    required this.population,
    required this.currencies,
    required this.timezones,
    required this.area,
    required this.maps,
    this.gini,
    required this.borders,
    required this.startOfWeek,
  });

  @override
  List<Object?> get props => [
        name,
        officialName,
        capitals,
        languages,
        flagUrl,
        flagEmoji,
        region,
        subregion,
        population,
        currencies,
        timezones,
        area,
        maps,
        gini,
        borders,
        startOfWeek,
      ];
}
