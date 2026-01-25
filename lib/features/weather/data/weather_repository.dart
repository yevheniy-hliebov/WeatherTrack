import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:weathertrack/common/exceptions/network_exception.dart';
import 'package:weathertrack/common/models/coordinate.dart';
import 'package:weathertrack/core/constants/api.dart';
import 'package:weathertrack/features/weather/data/models/forecast_response.dart';
import 'package:weathertrack/features/weather/data/models/weather_response.dart';

class WeatherRepository {
  final http.Client client;

  WeatherRepository({http.Client? client}) : client = client ?? http.Client();

  static const Duration timeout = Duration(seconds: 10);

  Future<WeatherResponse> getCurrent(Coordinate coordinates) async {
    final uri = _buildUri('/weather', coordinates);

    return _handleRequest(() async {
      final response = await client.get(uri).timeout(timeout);
      return WeatherResponse.fromJson(_processResponse(response));
    });
  }

  Future<ForecastResponse> getForecast(Coordinate coordinates) async {
    final uri = _buildUri('/forecast', coordinates);

    return _handleRequest(() async {
      final response = await client.get(uri).timeout(timeout);
      return ForecastResponse.fromJson(_processResponse(response));
    });
  }

  Uri _buildUri(String path, Coordinate coordinates) {
    return Uri.parse('${Api.weather.url}$path').replace(
      queryParameters: {
        'lat': coordinates.latitude.toString(),
        'lon': coordinates.longitude.toString(),
        'appid': Api.weather.key,
        'units': 'metric',
      },
    );
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }

    final type = switch (response.statusCode) {
      401 => NetworkExceptionType.unauthorized,
      404 => NetworkExceptionType.notFound,
      429 => NetworkExceptionType.server,
      _ => NetworkExceptionType.server,
    };

    throw NetworkException(
      service: 'WeatherRepository',
      type: type,
      message: 'HTTP ${response.statusCode}: ${response.reasonPhrase}',
    );
  }

  Future<T> _handleRequest<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on SocketException {
      throw NetworkException(
        service: 'WeatherRepository',
        type: NetworkExceptionType.network,
        message: 'No internet connection',
      );
    } on TimeoutException {
      throw NetworkException(
        service: 'WeatherRepository',
        type: NetworkExceptionType.network,
        message: 'Connection timed out',
      );
    } catch (e) {
      if (e is NetworkException) rethrow;
      throw NetworkException(
        service: 'WeatherRepository',
        type: NetworkExceptionType.unknown,
        message: e.toString(),
      );
    }
  }
}
