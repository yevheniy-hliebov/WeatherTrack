import 'package:weathertrack/features/weather/data/models/weather_response.dart';

class ForecastResponse {
  final List<WeatherResponse> list;

  const ForecastResponse({required this.list});

  factory ForecastResponse.fromJson(Map<String, dynamic> json) {
    final listData = json['list'] as List?;

    return ForecastResponse(
      list: listData?.map((e) => WeatherResponse.fromJson(e)).toList() ?? [],
    );
  }
}
