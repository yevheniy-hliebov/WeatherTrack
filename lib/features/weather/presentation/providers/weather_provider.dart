import 'package:flutter/material.dart';
import 'package:weathertrack/common/exceptions/network_exception.dart';
import 'package:weathertrack/common/models/coordinate.dart';
import 'package:weathertrack/features/weather/data/weather_repository.dart';
import 'package:weathertrack/features/weather/presentation/providers/weather_state.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherRepository _repository;

  WeatherProvider(this._repository);

  WeatherState state = const WeatherState();

  Future<void> onSelectedCity(Coordinate coordinates) async {
    state = state.copyWith(
      coordinates: coordinates,
      currentWeather: null,
      forecast: null,
    );
    notifyListeners();

    await _handleRequest(_getWeather);
  }

  Future<void> onSelectTab(WeatherTab tab) async {
    state = state.copyWith(selectedTab: tab);
    notifyListeners();

    if (state.coordinates == null) return;

    final bool hasData = tab == WeatherTab.current
        ? state.currentWeather != null
        : state.forecast != null;

    if (!hasData) {
      await _handleRequest(_getWeather);
    }
  }

  Future<void> onRefresh() async {
    if (state.coordinates == null) return;

    await _handleRequest(_getWeather);
  }

  Future<void> _handleRequest(Future<void> Function() request) async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    notifyListeners();

    try {
      await request();
    } on NetworkException catch (e) {
      state = state.copyWith(errorMessage: e.message);
    } catch (e) {
      state = state.copyWith(errorMessage: 'An unexpected error occurred');
    } finally {
      state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  Future<void> _getWeather() async {
    if (state.coordinates == null) return;
    final coords = state.coordinates!;

    if (state.selectedTab == WeatherTab.current) {
      final response = await _repository.getCurrent(coords);
      state = state.copyWith(currentWeather: response);
    } else {
      final response = await _repository.getForecast(coords);
      state = state.copyWith(forecast: response);
    }
  }
}
