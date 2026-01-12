import 'package:weathertrack/common/models/city_model.dart';

class CityHistoryState {
  final bool isLoading;
  final CityModel? selectedCity;
  final List<CityModel> history;
  final String errorMessage;

  const CityHistoryState({
    this.isLoading = false,
    this.selectedCity,
    this.history = const [],
    this.errorMessage = '',
  });

  CityHistoryState copyWith({
    bool? isLoading,
    CityModel? selectedCity,
    List<CityModel>? history,
    String? errorMessage,
  }) {
    return CityHistoryState(
      isLoading: isLoading ?? this.isLoading,
      selectedCity: selectedCity ?? this.selectedCity,
      history: history ?? this.history,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
