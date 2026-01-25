import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weathertrack/common/exceptions/network_exception.dart';
import 'package:weathertrack/common/models/city_model.dart';
import 'package:weathertrack/features/city_search/data/city_search_repository.dart';
import 'package:weathertrack/features/city_search/presentation/providers/city_search_provider.dart';

import '../fixtures/city_fixtures.dart';

class MockCitySearchRepository extends Mock implements CitySearchRepository {}

void main() {
  late CitySearchProvider provider;
  late MockCitySearchRepository mockRepository;

  setUp(() {
    mockRepository = MockCitySearchRepository();
    provider = CitySearchProvider(mockRepository);
  });

  group('CitySearchProvider', () {
    test('should have initial empty state', () {
      expect(provider.state.cities, isEmpty);
      expect(provider.state.isLoading, isFalse);
      expect(provider.state.errorMessage, isEmpty);
    });

    test('should return base immediatly when query is empty', () {
      provider.onQueryChanged('');

      expect(provider.state.cities, isEmpty);
      verifyNever(() => mockRepository.fetch(any()));
    });

    test('should call repository after debounce duration', () {
      fakeAsync((async) {
        when(() => mockRepository.fetch(any())).thenAnswer((_) async => []);

        provider.onQueryChanged('Aixirivall');

        verifyNever(() => mockRepository.fetch('Aixirivall'));
        async.elapse(const Duration(milliseconds: 500));
        verify(() => mockRepository.fetch('Aixirivall')).called(1);
      });
    });

    test('should update state with cities on successful search', () {
      fakeAsync((async) {
        final completer = Completer<List<CityModel>>();

        when(
          () => mockRepository.fetch(any()),
        ).thenAnswer((_) => completer.future);

        provider.onQueryChanged('Aixirivall');

        async.elapse(const Duration(milliseconds: 500));
        async.flushMicrotasks();

        expect(provider.state.isLoading, isTrue);

        completer.complete(CityFixtures.mockCities);

        async.flushMicrotasks();

        expect(provider.state.isLoading, isFalse);
        expect(provider.state.cities, CityFixtures.mockCities);
      });
    });

    test('should update state with error message on NetworkException', () {
      fakeAsync((async) {
        const errorMsg = 'No internet connection';
        when(() => mockRepository.fetch(any())).thenThrow(
          NetworkException(
            type: NetworkExceptionType.network,
            message: errorMsg,
          ),
        );

        provider.onQueryChanged('Aixirivall');
        async.elapse(const Duration(milliseconds: 500));
        async.flushMicrotasks();

        expect(provider.state.isLoading, isFalse);
        expect(provider.state.cities, isEmpty);
        expect(provider.state.errorMessage, errorMsg);
      });
    });

    test(
      'should set unexpected error message when an unknown error occurs',
      () {
        fakeAsync((async) {
          when(
            () => mockRepository.fetch(any()),
          ).thenThrow(Exception('Database crash'));

          provider.onQueryChanged('Aixirivall');
          async.elapse(const Duration(milliseconds: 500));
          async.flushMicrotasks();

          expect(provider.state.errorMessage, 'An unexpected error occurred');
          expect(provider.state.isLoading, isFalse);
          expect(provider.state.cities, isEmpty);
        });
      },
    );
  });
}
