import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:weathertrack/features/city_search/data/city_model.dart';
import 'package:weathertrack/features/city_search/data/city_search_exceptions.dart';
import 'package:weathertrack/features/city_search/data/city_search_repository.dart';

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late CitySearchRepository repository;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    repository = CitySearchRepository(client: mockHttpClient);
  });

  group('CitySearchRepositoty - fetch', () {
    final namePrefix = 'Aix';
    final mockResponse = {
      'data': [
        {
          'id': 3350606,
          'wikiDataId': 'Q24668',
          'type': 'CITY',
          'city': 'Aixirivall',
          'name': 'Aixirivall',
          'country': 'Andorra',
          'countryCode': 'AD',
          'region': 'Sant Julià de Lòria',
          'regionCode': '06',
          'latitude': 42.46245,
          'longitude': 1.50209,
          'population': 0,
        },
        {
          'id': 3216144,
          'wikiDataId': 'Q24656',
          'type': 'CITY',
          'city': 'Aixovall',
          'name': 'Aixovall',
          'country': 'Andorra',
          'countryCode': 'AD',
          'region': 'Sant Julià de Lòria',
          'regionCode': '06',
          'latitude': 42.47635833,
          'longitude': 1.48949167,
          'population': 0,
        },
      ],
    };

    test(
      'should return List<CityModel> when the response code is 200 (Success)',
      () async {
        final jsonString = jsonEncode(mockResponse);
        final bytes = utf8.encode(jsonString);

        when(
          () => mockHttpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => http.Response.bytes(bytes, 200));

        final result = await repository.fetch(namePrefix);

        expect(result, isA<List<CityModel>>());
        expect(result.length, 2);
        expect(result.first.name, 'Aixirivall');
      },
    );

    test(
      'should throw CitySearchException with type server when the response code is 404',
      () {
        when(
          () => mockHttpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => http.Response('Not Found', 404));

        expect(
          () => repository.fetch(namePrefix),
          throwsA(
            isA<CitySearchException>().having(
              (e) => e.type,
              'type',
              CityExceptionType.server,
            ),
          ),
        );
      },
    );

    test(
      'should throw CitySearchException with type network when a SocketException occurs',
      () async {
        when(
          () => mockHttpClient.get(any(), headers: any(named: 'headers')),
        ).thenThrow(const SocketException('No Internet'));

        expect(
          () => repository.fetch(namePrefix),
          throwsA(
            isA<CitySearchException>().having(
              (e) => e.type,
              'type',
              CityExceptionType.network,
            ),
          ),
        );
      },
    );

    test(
      'should throw CitySearchException with type unknown when parsing fails',
      () async {
        when(
          () => mockHttpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => http.Response('invalid json', 200));

        expect(
          () => repository.fetch(namePrefix),
          throwsA(
            isA<CitySearchException>().having(
              (e) => e.type,
              'type',
              CityExceptionType.unknown,
            ),
          ),
        );
      },
    );
  });
}
