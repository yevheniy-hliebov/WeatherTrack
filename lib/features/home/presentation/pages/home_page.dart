import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weathertrack/common/widgets/app_background.dart';
import 'package:weathertrack/core/constants/spacing.dart';
import 'package:weathertrack/features/city_history/presentation/providers/city_history_provider.dart';
import 'package:weathertrack/features/city_history/presentation/widgets/city_search_history.dart';
import 'package:weathertrack/features/city_search/presentation/widgets/city_search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final historyProvider = context.watch<CityHistoryProvider>();

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.md),
            child: Column(
              spacing: Spacing.sm,
              children: [
                CitySearchBar(
                  onSelect: (city) => historyProvider.addToHistory(city),
                ),
                const CitySearchHistory(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
