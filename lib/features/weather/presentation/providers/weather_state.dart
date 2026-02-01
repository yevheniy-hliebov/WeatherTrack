import 'package:weathertrack/common/models/coordinate.dart';
import 'package:weathertrack/features/weather/data/models/forecast_response.dart';
import 'package:weathertrack/features/weather/data/models/weather_response.dart';

enum WeatherTab { current, forecast }

class WeatherState {
  final bool isLoading;
  final Coordinate? coordinates;
  final WeatherTab selectedTab;
  final WeatherResponse? currentWeather;
  final ForecastResponse? forecast;
  final String errorMessage;

  const WeatherState({
    this.isLoading = false,
    this.coordinates,
    this.selectedTab = .current,
    this.currentWeather,
    this.forecast,
    this.errorMessage = '',
  });

  static const _undefined = Object();

  WeatherState copyWith({
    bool? isLoading,
    Coordinate? coordinates,
    WeatherTab? selectedTab,
    Object? currentWeather = _undefined,
    Object? forecast = _undefined,
    String? errorMessage,
  }) {
    return WeatherState(
      isLoading: isLoading ?? this.isLoading,
      coordinates: coordinates ?? this.coordinates,
      selectedTab: selectedTab ?? this.selectedTab,
      currentWeather: currentWeather == _undefined
          ? this.currentWeather
          : currentWeather as WeatherResponse?,

      forecast: forecast == _undefined
          ? this.forecast
          : forecast as ForecastResponse?,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  WeatherState startLoading() {
    return WeatherState(
      isLoading: true,
      coordinates: coordinates,
      selectedTab: selectedTab,
      currentWeather: currentWeather,
      forecast: forecast,
    );
  }
}
