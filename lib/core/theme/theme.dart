import 'package:flutter/material.dart';
import 'package:weathertrack/core/constants/colors.dart';

part 'components/text_theme.dart';

abstract class AppTheme {
  AppTheme._();

  static final TextTheme _textTheme = AppTextTheme.text;

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    primaryColor: AppColors.primary,
    textTheme: _textTheme,
    textSelectionTheme: AppTextTheme.textSelection,
    iconTheme: const IconThemeData(color: AppColors.primary),
  );
}
