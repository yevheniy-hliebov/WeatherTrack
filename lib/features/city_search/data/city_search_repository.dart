import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:weathertrack/core/constants/api.dart';
import 'package:weathertrack/features/city_search/data/city_search_exceptions.dart';
import 'package:weathertrack/features/city_search/data/city_model.dart';

class CitySearchRepository {
  final http.Client client;

  CitySearchRepository({http.Client? client}) : client = client ?? http.Client();

  Future<List<CityModel>> fetch(String namePrefix) async {
    final uri = Uri.parse('${Api.geo.url}/cities').replace(
      queryParameters: {
        'minPopulation': Api.geo.population.toString(),
        'namePrefix': namePrefix,
      },
    );

    try {
      final response = await client.get(
        uri,
        headers: {'X-RapidAPI-Key': Api.geo.xRapidapiKey},
      );

      if (response.statusCode == 200) {
        String decodedString = utf8.decode(response.bodyBytes);
        final decodedResponse = jsonDecode(decodedString);
        return CityModel.fromJsonList(decodedResponse['data']);
      } else {
        throw CitySearchException(
          type: CityExceptionType.server,
          message: 'Server Error: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw CitySearchException(
        type: CityExceptionType.network,
        message: 'No internet connection',
      );
    } on TimeoutException {
      throw CitySearchException(
        type: CityExceptionType.network,
        message: 'Connection timed out',
      );
    } on CitySearchException {
      rethrow;
    } catch (e) {
      throw CitySearchException(
        type: CityExceptionType.unknown,
        message: e.toString(),
      );
    }
  }
}
