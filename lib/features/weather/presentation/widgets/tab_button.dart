import 'package:flutter/material.dart';
import 'package:weathertrack/core/constants/colors.dart';
import 'package:weathertrack/core/constants/corners.dart';
import 'package:weathertrack/core/constants/spacing.dart';

class TabButton extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback? onTap;

  const TabButton({
    super.key,
    required this.text,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selected ? null : onTap,
      borderRadius: BorderRadius.circular(AppCorners.md),
      child: Container(
        width: double.maxFinite,
        constraints: const BoxConstraints(maxWidth: 146),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 1),
          borderRadius: BorderRadius.circular(AppCorners.md),
          color: selected ? AppColors.primary : Colors.transparent,
        ),
        alignment: .center,
        padding: const EdgeInsets.all(Spacing.xs),
        child: Text(
          text,
          style: TextTheme.of(context).bodyLarge?.copyWith(
            color: selected ? AppColors.inverseText : AppColors.text,
          ),
        ),
      ),
    );
  }
}
