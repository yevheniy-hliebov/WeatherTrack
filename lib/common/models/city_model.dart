import 'package:weathertrack/common/models/coordinate.dart';

class CityModel {
  final int id;
  final String name;
  final String countryCode;
  final Coordinate coordinates;

  const CityModel({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.coordinates,
  });

  String get nameAndCountryCode => '$name, ${countryCode.toUpperCase()}';

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: int.parse(json['id'].toString()),
      name: json['name'],
      countryCode: json['countryCode'],
      coordinates: Coordinate(
        latitude: double.parse(json['latitude'].toString()),
        longitude: double.parse(json['longitude'].toString()),
      ),
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
      'latitude': coordinates.latitude,
      'longitude': coordinates.longitude,
    };
  }
}
