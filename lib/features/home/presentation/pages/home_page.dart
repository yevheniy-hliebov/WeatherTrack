import 'package:flutter/material.dart';
import 'package:weathertrack/core/constants/spacing.dart';
import 'package:weathertrack/features/city_search/presentation/widgets/city_search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          children: [
            CitySearchBar(),
          ],
        ),
      ),
    );
  }
}
