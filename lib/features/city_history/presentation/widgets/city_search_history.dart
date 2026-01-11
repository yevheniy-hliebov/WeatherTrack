import 'package:flutter/material.dart';
import 'package:weathertrack/common/widgets/loader.dart';
import 'package:weathertrack/core/constants/colors.dart';
import 'package:weathertrack/core/constants/spacing.dart';
import 'package:weathertrack/features/city_history/presentation/widgets/city_history_list.dart';

import 'package:provider/provider.dart';
import 'package:weathertrack/features/city_history/presentation/providers/city_history_provider.dart';

class CitySearchHistory extends StatelessWidget {
  const CitySearchHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final historyProvider = context.watch<CityHistoryProvider>();
    final state = historyProvider.state;

    if (state.history.isEmpty && !state.isLoading) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'City search history',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: Spacing.sm),

        if (state.isLoading)
          const Loader()
        else
          CityHistoryList(
            cities: state.history,
            selectedCity: state.selectedCity,
            onSelect: (city) {
              historyProvider.selectCity(city);
            },
          ),

        if (state.errorMessage.isNotEmpty)
          Text(
            state.errorMessage,
            style: TextTheme.of(
              context,
            ).bodyMedium?.copyWith(color: AppColors.error),
          ),
      ],
    );
  }
}
