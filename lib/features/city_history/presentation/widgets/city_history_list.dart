import 'package:flutter/material.dart';
import 'package:weathertrack/core/constants/spacing.dart';
import 'package:weathertrack/features/city_history/presentation/widgets/city_chip.dart';
import 'package:weathertrack/features/city_search/data/city_model.dart';

class CityHistoryList extends StatelessWidget {
  final CityModel? selectedCity;
  final List<CityModel> cities;
  final void Function(CityModel city)? onSelect;

  const CityHistoryList({
    super.key,
    this.selectedCity,
    this.cities = const [],
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    if (cities.isEmpty) {
      return const Text('History is empty');
    }

    return Wrap(
      spacing: Spacing.sm,
      runSpacing: Spacing.sm,
      crossAxisAlignment: .center,
      alignment: .center,
      children: cities.map((city) {
        final selected = selectedCity?.id == city.id;
        return CityChip(
          selected: selected,
          onTap: selected ? null : () => onSelect?.call(city),
          text: city.nameAndCountryCode,
        );
      }).toList(),
    );
  }
}
