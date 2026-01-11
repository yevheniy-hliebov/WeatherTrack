import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weathertrack/core/di/service_locator.dart';
import 'package:weathertrack/features/city_history/data/city_history_repository.dart';

import '../fixtures/city_fixtures.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late CityHistoryRepository repository;
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    repository = CityHistoryRepository(prefs: mockPrefs);
  });

  const String historyKey = 'city_search_history';

  final mockCity = CityFixtures.mockCities[0];

  final mockHistoryString = CityFixtures.mockHistory
      .map((c) => jsonEncode(c.toJson()))
      .toList();

  group('CityHistoryRepository', () {
    test('should return an empty list when no history exists in storage', () {
      when(() => mockPrefs.getStringList(historyKey)).thenReturn(null);

      final result = repository.getHistory();

      expect(result, isEmpty);
      verify(() => mockPrefs.getStringList(historyKey)).called(1);
    });

    test('should return a list of CityModel when valid JSON data exists', () {
      when(
        () => mockPrefs.getStringList(historyKey),
      ).thenReturn(mockHistoryString);

      final result = repository.getHistory();

      expect(result, isNotEmpty);
      expect(result.length, 5);
      verify(() => mockPrefs.getStringList(historyKey)).called(1);
    });

    test(
      'should add a new city to the top (index 0) of the history list',
      () async {
        when(
          () => mockPrefs.getStringList(historyKey),
        ).thenReturn(mockHistoryString);
        when(
          () => mockPrefs.setStringList(historyKey, any()),
        ).thenAnswer((_) async => true);

        final result = await repository.addToHistory(mockCity);

        expect(result.length, 5);
        expect(result.first.id, mockCity.id);
        verify(() => mockPrefs.getStringList(historyKey)).called(1);
        verify(() => mockPrefs.setStringList(historyKey, any())).called(1);
      },
    );

    test(
      'should remove existing city and move it to the top to avoid duplicates',
      () async {
        when(
          () => mockPrefs.getStringList(historyKey),
        ).thenReturn(mockHistoryString);
        when(
          () => mockPrefs.setStringList(historyKey, any()),
        ).thenAnswer((_) async => true);

        final result = await repository.addToHistory(
          CityFixtures.mockHistory[1],
        );

        expect(result.length, 5);
        expect(result.first.id, CityFixtures.mockHistory[1].id);
        expect(result[1].id, CityFixtures.mockHistory[0].id);
        expect(result[2].id, CityFixtures.mockHistory[2].id);
        verify(() => mockPrefs.getStringList(historyKey)).called(1);
        verify(() => mockPrefs.setStringList(historyKey, any())).called(1);
      },
    );

    test(
      'should remove the oldest item when history exceeds the maximum length of 5',
      () async {
        when(
          () => mockPrefs.getStringList(historyKey),
        ).thenReturn(mockHistoryString);
        when(
          () => mockPrefs.setStringList(historyKey, any()),
        ).thenAnswer((_) async => true);

        final result = await repository.addToHistory(mockCity);

        expect(result.length, 5);
        expect(result.first.id, mockCity.id);

        final containsOldest = result.any(
          (city) => city.id == CityFixtures.mockHistory.last.id,
        );
        expect(containsOldest, isFalse);

        verify(() => mockPrefs.getStringList(historyKey)).called(1);
        verify(
          () => mockPrefs.setStringList(historyKey, any(that: hasLength(5))),
        ).called(1);
      },
    );

    test(
      'should successfully remove the history key from the storage when cleared',
      () async {
        when(() => mockPrefs.remove(historyKey)).thenAnswer((_) async => true);

        await repository.clearHistory();

        verify(() => mockPrefs.remove(historyKey)).called(1);
        verifyNoMoreInteractions(mockPrefs);
      },
    );
  });
}
