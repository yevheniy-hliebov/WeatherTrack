import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weathertrack/features/city_search/data/city_model.dart';

class CityHistoryRepository {
  static const String _historyKey = 'city_search_history';
  static const int _maxHistoryLength = 5;

  final SharedPreferences _prefs;

  const CityHistoryRepository({required SharedPreferences prefs})
    : _prefs = prefs;

  List<CityModel> getHistory() {
    final List<String> jsonList = _prefs.getStringList(_historyKey) ?? [];

    return jsonList.map((jsonString) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return CityModel.fromJson(jsonMap);
    }).toList();
  }

  Future<List<CityModel>> addToHistory(CityModel city) async {
    final history = getHistory();

    history
      ..removeWhere((item) => item.id == city.id)
      ..insert(0, city);

    if (history.length > _maxHistoryLength) {
      history.removeLast();
    }

    await _prefs.setStringList(
      _historyKey,
      history.map((c) => jsonEncode(c.toJson())).toList(),
    );

    return history;
  }

  Future<void> clearHistory() async {
    await _prefs.remove(_historyKey);
  }
}
