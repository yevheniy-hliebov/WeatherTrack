import 'package:weathertrack/features/weather/data/models/atmospheric_pressure.dart';
import 'package:weathertrack/features/weather/data/models/temperature.dart';
import 'package:weathertrack/features/weather/data/models/weather_condition.dart';
import 'package:weathertrack/features/weather/data/models/wind.dart';

class WeatherResponse {
  final WeatherCondition condition;
  final Temperature temperature;
  final int humidity;
  final int visibility;
  final AtmosphericPressure pressure;
  final Wind wind;
  final int clouds;
  final double? rain1h;
  final double? rain3h;
  final double? snow1h;
  final double? snow3h;
  final DateTime? date;
  final int? timezone;
  final String? dtTxt;

  WeatherResponse({
    required this.condition,
    required this.temperature,
    required this.humidity,
    required this.visibility,
    required this.pressure,
    required this.wind,
    required this.clouds,
    this.rain1h,
    this.rain3h,
    this.snow1h,
    this.snow3h,
    this.date,
    this.timezone,
    this.dtTxt,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final main = json['main'] as Map<String, dynamic>? ?? {};
    final weatherList = json['weather'] as List? ?? [];
    final cloudsMap = json['clouds'] as Map<String, dynamic>? ?? {};

    return WeatherResponse(
      condition: WeatherCondition.fromJson(
        weatherList.isNotEmpty ? weatherList[0] : {},
      ),
      temperature: Temperature.fromJson(main),
      pressure: AtmosphericPressure.fromJson(main),
      wind: Wind.fromJson(json['wind'] as Map<String, dynamic>? ?? {}),

      humidity: (main['humidity'] as num?)?.toInt() ?? 0,
      visibility: (json['visibility'] as num?)?.toInt() ?? 0,
      clouds: (cloudsMap['all'] as num?)?.toInt() ?? 0,

      rain1h: (json['rain']?['1h'] as num?)?.toDouble(),
      rain3h: (json['rain']?['3h'] as num?)?.toDouble(),
      snow1h: (json['snow']?['1h'] as num?)?.toDouble(),
      snow3h: (json['snow']?['3h'] as num?)?.toDouble(),

      date: json['dt'] != null
          ? DateTime.fromMillisecondsSinceEpoch((json['dt'] as int) * 1000)
          : null,
      timezone: (json['timezone'] as num?)?.toInt(),
      dtTxt: json['dt_txt'] as String?,
    );
  }
}
