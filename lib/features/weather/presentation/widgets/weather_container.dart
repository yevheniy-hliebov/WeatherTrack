import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weathertrack/common/widgets/glass_container.dart';
import 'package:weathertrack/core/constants/corners.dart';
import 'package:weathertrack/core/constants/image_paths.dart';
import 'package:weathertrack/core/constants/spacing.dart';
import 'package:weathertrack/features/weather/presentation/widgets/tab_button.dart';

class WeatherContainer extends StatelessWidget {
  final String city;

  const WeatherContainer({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      bordered: true,
      transparency: true,
      radius: AppCorners.lg,
      padding: const EdgeInsets.all(Spacing.xl),
      child: Column(
        spacing: Spacing.sm,
        mainAxisSize: .min,
        children: [
          Row(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            mainAxisSize: .max,
            children: [
              SvgPicture.asset('${ImagePaths.icons}/location.svg'),
              Text(city, style: TextTheme.of(context).headlineMedium),
            ],
          ),
          Row(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            spacing: Spacing.sm,
            mainAxisSize: .max,
            children: [
              TabButton(text: 'Current', selected: true, onTap: () {debugPrint('Current');}),
              TabButton(text: 'Forecast', selected: false, onTap: () {debugPrint('Forecast');}),
            ],
          ),
        ],
      ),
    );
  }
}
