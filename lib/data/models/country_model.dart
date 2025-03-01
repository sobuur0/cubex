import '../../domain/entities/country.dart';

class CountryModel extends Country {
  const CountryModel({
    required super.name,
    required super.capitals,
    required super.languages,
    required super.flagUrl,
    required super.flagEmoji,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    final name = json['name']['common'] as String;

    final capitals = <String>[];
    if (json['capital'] != null) {
      capitals.addAll((json['capital'] as List).map((e) => e as String));
    }

    final languages = <String, String>{};
    if (json['languages'] != null) {
      json['languages'].forEach((key, value) {
        languages[key] = value;
      });
    }

    final flagUrl = json['flags']['png'] as String;
    final flagEmoji = json['flags']['alt'] != null
        ? json['flags']['alt'] as String
        : 'Flag of $name';

    return CountryModel(
      name: name,
      capitals: capitals,
      languages: languages,
      flagUrl: flagUrl,
      flagEmoji: flagEmoji,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': {
        'common': name,
      },
      'capital': capitals,
      'languages': languages,
      'flags': {
        'png': flagUrl,
        'alt': flagEmoji,
      },
    };
  }
}
