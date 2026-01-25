import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:weathertrack/common/exceptions/network_exception.dart';
import 'package:weathertrack/common/models/city_model.dart';
import 'package:weathertrack/features/city_search/data/city_search_repository.dart';

import '../fixtures/city_fixtures.dart';

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

    test(
      'should return List<CityModel> when the response code is 200 (Success)',
      () async {
        final jsonString = jsonEncode(CityFixtures.mockResponse);
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
      'should throw NetworkException with type server when the response code is 404',
      () {
        when(
          () => mockHttpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => http.Response('Not Found', 404));

        expect(
          () => repository.fetch(namePrefix),
          throwsA(
            isA<NetworkException>().having(
              (e) => e.type,
              'type',
              NetworkExceptionType.server,
            ),
          ),
        );
      },
    );

    test(
      'should throw NetworkException with type network when a SocketException occurs',
      () async {
        when(
          () => mockHttpClient.get(any(), headers: any(named: 'headers')),
        ).thenThrow(const SocketException('No Internet'));

        expect(
          () => repository.fetch(namePrefix),
          throwsA(
            isA<NetworkException>().having(
              (e) => e.type,
              'type',
              NetworkExceptionType.network,
            ),
          ),
        );
      },
    );

    test(
      'should throw NetworkException with type unknown when parsing fails',
      () async {
        when(
          () => mockHttpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => http.Response('invalid json', 200));

        expect(
          () => repository.fetch(namePrefix),
          throwsA(
            isA<NetworkException>().having(
              (e) => e.type,
              'type',
              NetworkExceptionType.unknown,
            ),
          ),
        );
      },
    );
  });
}
