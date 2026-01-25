import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:weathertrack/common/exceptions/network_exception.dart';
import 'package:weathertrack/core/constants/api.dart';
import 'package:weathertrack/common/models/city_model.dart';

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
        throw NetworkException(
          service: 'CitySearchRepository',
          type: NetworkExceptionType.server,
          message: 'Server Error: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw NetworkException(
        service: 'CitySearchRepository',
        type: NetworkExceptionType.network,
        message: 'No internet connection',
      );
    } on TimeoutException {
      throw NetworkException(
        service: 'CitySearchRepository',
        type: NetworkExceptionType.network,
        message: 'Connection timed out',
      );
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        service: 'CitySearchRepository',
        type: NetworkExceptionType.unknown,
        message: e.toString(),
      );
    }
  }
}
