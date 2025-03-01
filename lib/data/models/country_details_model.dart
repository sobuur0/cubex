import '../../domain/entities/country.dart';

class CountryDetailsModel extends CountryDetails {
  const CountryDetailsModel({
    required super.name,
    required super.officialName,
    required super.capitals,
    required super.languages,
    required super.flagUrl,
    required super.flagEmoji,
    required super.region,
    required super.subregion,
    required super.population,
    required super.currencies,
    required super.timezones,
    required super.area,
    required super.maps,
    super.gini,
    required super.borders,
    required super.startOfWeek,
  });

  factory CountryDetailsModel.fromJson(Map<String, dynamic> json) {
    final name = json['name']['common'] as String;
    final officialName = json['name']['official'] as String;

    final capitals = <String>[];
    if (json['capital'] != null) {
      capitals.addAll((json['capital'] as List).map((e) => e as String));
    }

    final languages = <String, String>{};
    if (json['languages'] != null) {
      json['languages'].forEach((key, value) {
        languages[key] = value.toString();
      });
    }

    final flagUrl = json['flags']['png'] as String? ?? '';
    final flagEmoji = json['flags']['alt'] as String? ?? 'Flag of $name';

    final region = json['region'] as String? ?? '';
    final subregion = json['subregion'] as String? ?? '';

    final population = json['population'] as int? ?? 0;

    final currencies = <String>[];
    if (json['currencies'] != null) {
      json['currencies'].forEach((key, value) {
        currencies.add('${value['name']} (${value['symbol']})');
      });
    }

    final timezones = <String>[];
    if (json['timezones'] != null) {
      timezones.addAll((json['timezones'] as List).map((e) => e.toString()));
    }

    final area = (json['area'] as num?)?.toDouble() ?? 0.0;

    final maps = json['maps'] as Map<String, dynamic>? ?? {};

    int? gini;
    if (json['gini'] != null) {
      final giniValues = json['gini'] as Map<String, dynamic>;
      if (giniValues.isNotEmpty) {
        final mostRecentYear = giniValues.keys.toList()
          ..sort((a, b) => int.parse(b).compareTo(int.parse(a)));
        if (mostRecentYear.isNotEmpty) {
          gini = (giniValues[mostRecentYear.first] as num).toInt();
        }
      }
    }

    final borders = <String>[];
    if (json['borders'] != null) {
      borders.addAll((json['borders'] as List).map((e) => e.toString()));
    }

    final startOfWeek = json['startOfWeek'] as String? ?? 'monday';

    return CountryDetailsModel(
      name: name,
      officialName: officialName,
      capitals: capitals,
      languages: languages,
      flagUrl: flagUrl,
      flagEmoji: flagEmoji,
      region: region,
      subregion: subregion,
      population: population,
      currencies: currencies,
      timezones: timezones,
      area: area,
      maps: maps,
      gini: gini,
      borders: borders,
      startOfWeek: startOfWeek,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': {
        'common': name,
        'official': officialName,
      },
      'capital': capitals,
      'languages': languages,
      'flags': {
        'png': flagUrl,
        'alt': flagEmoji,
      },
      'region': region,
      'subregion': subregion,
      'population': population,
      'currencies': currencies,
      'timezones': timezones,
      'area': area,
      'maps': maps,
      'gini': gini,
      'borders': borders,
      'startOfWeek': startOfWeek,
    };
  }
}
