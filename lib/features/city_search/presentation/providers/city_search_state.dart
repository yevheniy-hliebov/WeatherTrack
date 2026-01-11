import 'package:weathertrack/features/city_search/data/city_model.dart';

class CitySearchState {
  final bool isLoading;
  final List<CityModel> cities;
  final String errorMessage;

  CitySearchState({
    this.isLoading = false,
    this.cities = const [],
    this.errorMessage = '',
  });

  CitySearchState base() {
    return CitySearchState();
  }

  CitySearchState copyWith({
    bool? isLoading,
    List<CityModel>? cities,
    String? errorMessage,
  }) {
    return CitySearchState(
      isLoading: isLoading ?? this.isLoading,
      cities: cities ?? this.cities,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
