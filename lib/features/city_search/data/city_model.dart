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
      id: int.parse(json['id'].toString()),
      wikiDataId: json['wikiDataId'],
      type: json['type'],
      city: json['city'],
      name: json['name'],
      country: json['country'],
      countryCode: json['countryCode'],
      region: json['region'],
      regionCode: json['regionCode'],
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
      population: double.parse(json['population'].toString()),
    );
  }

  static List<CityModel> fromJsonList(List<dynamic> list) {
    return list.map((object) => CityModel.fromJson(object)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'wikiDataId': wikiDataId,
      'type': type,
      'city': city,
      'name': name,
      'country': country,
      'countryCode': countryCode,
      'region': region,
      'regionCode': regionCode,
      'latitude': latitude,
      'longitude': longitude,
      'population': population,
    };
  }
}
