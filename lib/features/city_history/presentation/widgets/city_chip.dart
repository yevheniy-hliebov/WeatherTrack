import 'package:flutter/material.dart';
import 'package:weathertrack/core/constants/colors.dart';
import 'package:weathertrack/core/constants/corners.dart';
import 'package:weathertrack/core/constants/spacing.dart';

class CityChip extends StatelessWidget {
  final bool selected;
  final void Function()? onTap;
  final String text;

  const CityChip({
    super.key,
    this.selected = false,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : AppColors.opaqueGlassBg,
        borderRadius: BorderRadius.circular(AppCorners.sm),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppCorners.sm),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.sm,
              vertical: Spacing.xs,
            ),
            child: Text(
              text,
              style: TextTheme.of(context).bodyMedium?.copyWith(
                color: selected ? AppColors.inverseText : AppColors.text,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
