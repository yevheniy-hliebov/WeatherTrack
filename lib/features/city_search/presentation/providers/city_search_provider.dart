import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weathertrack/features/city_search/data/city_search_exceptions.dart';
import 'package:weathertrack/features/city_search/data/city_search_repository.dart';
import 'package:weathertrack/features/city_search/presentation/providers/city_search_state.dart';

class CitySearchProvider extends ChangeNotifier {
  final CitySearchRepository _repository;
  final Duration debounceDuration;

  CitySearchProvider(
    this._repository, {
    this.debounceDuration = const Duration(milliseconds: 500),
  });

  CitySearchState state = CitySearchState();

  Timer? _timer;

  void onQueryChanged(String query) {
    _timer?.cancel();

    if (query.isEmpty) {
      _updateState(state.base());
      return;
    }

    _timer = Timer(debounceDuration, () {
      _fetchCities(query);
    });
  }

  Future<void> _fetchCities(String query) async {
    _updateState(state.copyWith(isLoading: true, errorMessage: ''));

    try {
      final results = await _repository.fetch(query);
      _updateState(state.copyWith(cities: results, isLoading: false));
    } on CitySearchException catch (e) {
      _updateState(
        state.copyWith(isLoading: false, errorMessage: e.message, cities: []),
      );
    } catch (e) {
      _updateState(
        state.copyWith(
          isLoading: false,
          errorMessage: 'An unexpected error occurred',
          cities: [],
        ),
      );
    }
  }

  void _updateState(CitySearchState newState) {
    state = newState;
    notifyListeners();
  }
}
