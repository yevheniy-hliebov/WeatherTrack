import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weathertrack/features/city_history/data/city_history_repository.dart';
import 'package:weathertrack/features/city_history/presentation/providers/city_history_provider.dart';

import '../fixtures/city_fixtures.dart';

class MockCityHistoryRepository extends Mock implements CityHistoryRepository {}

void main() {
  late CityHistoryProvider provider;
  late MockCityHistoryRepository mockRepository;

  setUp(() {
    mockRepository = MockCityHistoryRepository();
    provider = CityHistoryProvider(mockRepository);
  });

  final mockCity = CityFixtures.mockCities[0];

  group('CityHistoryProvider', () {
    test('should have initial empty state when initialized', () {
      expect(provider.state.history, isEmpty);
      expect(provider.state.isLoading, isFalse);
      expect(provider.state.selectedCity, null);
      expect(provider.state.errorMessage, isEmpty);
    });

    test(
      'should update state with history when getHistory is called successfully',
      () {
        when(
          () => mockRepository.getHistory(),
        ).thenReturn(CityFixtures.mockHistory);

        provider.getHistory();

        expect(provider.state.history, CityFixtures.mockHistory);
        verify(() => mockRepository.getHistory()).called(1);
      },
    );

    test('should set error message when getHistory throws an exception', () {
      when(
        () => mockRepository.getHistory(),
      ).thenThrow(Exception('Storage error'));

      provider.getHistory();

      expect(provider.state.isLoading, isFalse);
      expect(provider.state.history, isEmpty);
      expect(provider.state.errorMessage, 'Failed to load search history');
      verify(() => mockRepository.getHistory()).called(1);
    });

    test(
      'should update selectedCity and clear error message when a city is selected',
      () {
        provider.selectCity(mockCity);

        expect(provider.state.selectedCity, isNotNull);
        expect(provider.state.selectedCity?.id, mockCity.id);
        expect(provider.state.errorMessage, isEmpty);
      },
    );

    test(
      'should call repository and update history list when addToHistory is called',
      () {
        fakeAsync((async) {
          final updatedHistory = [mockCity, ...CityFixtures.mockHistory];

          when(
            () => mockRepository.addToHistory(mockCity),
          ).thenAnswer((_) async => updatedHistory);

          provider.addToHistory(mockCity);

          expect(provider.state.selectedCity, mockCity);
          expect(provider.state.errorMessage, isEmpty);

          async.flushMicrotasks();

          verify(() => mockRepository.addToHistory(mockCity)).called(1);

          expect(provider.state.history, updatedHistory);
        });
      },
    );

    test('should set error message when addToHistory fails', () async {
      fakeAsync((async) {
        when(
          () => mockRepository.addToHistory(mockCity),
        ).thenThrow(Exception('Save error'));

        provider.addToHistory(mockCity);
        async.flushMicrotasks();

        expect(provider.state.errorMessage, 'Failed to save city to history');
        expect(provider.state.selectedCity, mockCity);
      });
    });

    test(
      'should clear history list and update state when clearHistory is called',
      () async {
        fakeAsync((async) {
          when(() => mockRepository.clearHistory()).thenAnswer((_) async => {});

          provider.clearHistory();
          async.flushMicrotasks();

          verify(() => mockRepository.clearHistory()).called(1);
          expect(provider.state.history, isEmpty);
          expect(provider.state.errorMessage, isEmpty);
        });
      },
    );

    test('should set error message when clearHistory fails', () async {
      fakeAsync((async) {
        when(
          () => mockRepository.clearHistory(),
        ).thenThrow(Exception('Delete error'));

        provider.clearHistory();
        async.flushMicrotasks();

        expect(provider.state.errorMessage, 'Failed to clear history');
        verify(() => mockRepository.clearHistory()).called(1);
      });
    });
  });
}
