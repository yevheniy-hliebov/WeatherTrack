import 'package:flutter/material.dart';
import 'package:weathertrack/core/constants/colors.dart';

class Loader extends StatelessWidget {
  final Color color;
  final double size;
  final double strokeWidth;
  final EdgeInsets padding;

  const Loader({
    super.key,
    this.color = AppColors.primary,
    this.size = 35,
    this.strokeWidth = 2,
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: size,
      height: size,
      child: CircularProgressIndicator(color: color, strokeWidth: strokeWidth),
    );
  }
}
