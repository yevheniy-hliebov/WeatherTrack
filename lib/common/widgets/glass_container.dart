import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weathertrack/core/constants/colors.dart';
import 'package:weathertrack/core/constants/corners.dart';

class GlassContainer extends StatelessWidget {
  final bool bordered;
  final bool transparency;
  final EdgeInsets? padding;
  final double radius;
  final Widget? child;

  final double blurValue = 4;

  const GlassContainer({
    super.key,
    this.bordered = false,
    this.transparency = true,
    this.padding,
    this.radius = AppCorners.lg,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: bordered ? AppColors.primary : Colors.transparent,
          width: 1,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: transparency ? AppColors.glassBg : AppColors.opaqueGlassBg,
              gradient: AppColors.glassGradient,
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Material(
              color: Colors.transparent,
              type: MaterialType.transparency,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
