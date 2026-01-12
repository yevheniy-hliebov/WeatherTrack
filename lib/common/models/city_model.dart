class CityModel {
  final int id;
  final String name;
  final String countryCode;
  final double latitude;
  final double longitude;

  const CityModel({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.latitude,
    required this.longitude,
  });

  String get nameAndCountryCode => '$name, ${countryCode.toUpperCase()}';

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: int.parse(json['id'].toString()),
      name: json['name'],
      countryCode: json['countryCode'],
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
    );
  }

  static List<CityModel> fromJsonList(List<dynamic> list) {
    return list.map((object) => CityModel.fromJson(object)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'countryCode': countryCode,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
