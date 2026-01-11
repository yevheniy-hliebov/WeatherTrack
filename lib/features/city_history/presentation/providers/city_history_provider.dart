import 'package:flutter/foundation.dart';
import 'package:weathertrack/features/city_history/data/city_history_repository.dart';
import 'package:weathertrack/features/city_history/presentation/providers/city_history_state.dart';
import 'package:weathertrack/features/city_search/data/city_model.dart';

class CityHistoryProvider extends ChangeNotifier {
  final CityHistoryRepository _repository;

  CityHistoryProvider(this._repository);

  CityHistoryState _state = const CityHistoryState();
  CityHistoryState get state => _state;

  void _updateState(CityHistoryState newState) {
    _state = newState;
    notifyListeners();
  }

  void getHistory() {
    _updateState(state.copyWith(isLoading: true, errorMessage: ''));
    try {
      final history = _repository.getHistory();
      _updateState(state.copyWith(history: history, isLoading: false));
    } catch (e) {
      _updateState(state.copyWith(
        isLoading: false, 
        errorMessage: 'Failed to load search history',
      ));
    }
  }

  void selectCity(CityModel city) {
    _updateState(state.copyWith(selectedCity: city, errorMessage: ''));
  }

  Future<void> addToHistory(CityModel city) async {
    _updateState(state.copyWith(selectedCity: city, errorMessage: ''));
    
    try {
      final updatedHistory = await _repository.addToHistory(city);
      _updateState(state.copyWith(history: updatedHistory));
    } catch (e) {
      _updateState(state.copyWith(
        errorMessage: 'Failed to save city to history',
      ));
    }
  }

  Future<void> clearHistory() async {
    try {
      await _repository.clearHistory();
      _updateState(state.copyWith(history: [], errorMessage: ''));
    } catch (e) {
      _updateState(state.copyWith(errorMessage: 'Failed to clear history'));
    }
  }
}
