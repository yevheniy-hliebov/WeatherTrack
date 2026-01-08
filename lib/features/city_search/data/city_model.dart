class CityModel {
  final int id;
  final String wikiDataId;
  final String type;
  final String city;
  final String name;
  final String country;
  final String countryCode;
  final String region;
  final String regionCode;
  final double latitude;
  final double longitude;
  final double population;

  const CityModel({
    required this.id,
    required this.wikiDataId,
    required this.type,
    required this.city,
    required this.name,
    required this.country,
    required this.countryCode,
    required this.region,
    required this.regionCode,
    required this.latitude,
    required this.longitude,
    required this.population,
  });

  String get nameAndCountryCode => '$name, ${countryCode.toUpperCase()}';

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      wikiDataId: json['wikiDataId'],
      type: json['type'],
      city: json['city'],
      name: json['name'],
      country: json['country'],
      countryCode: json['countryCode'],
      region: json['region'],
      regionCode: json['regionCode'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      population: json['population'],
    );
  }

  static List<CityModel> fromJsonList(List<dynamic> list) {
    return list.map((object) => CityModel.fromJson(object)).toList();
  }
}
