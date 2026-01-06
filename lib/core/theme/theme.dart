import 'package:flutter/material.dart';
import 'package:weathertrack/core/constants/colors.dart';

abstract class AppTheme {
  AppTheme._();

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    primaryColor: AppColors.primary,
    textTheme: TextTheme(
      titleLarge: const TextStyle().copyWith(color: AppColors.text),
      titleMedium: const TextStyle().copyWith(color: AppColors.text),
      headlineMedium: const TextStyle().copyWith(color: AppColors.text),
      displayLarge: const TextStyle().copyWith(
        color: AppColors.text,
        fontSize: 72,
        fontWeight: FontWeight.w800,
      ),
      bodyLarge: const TextStyle().copyWith(color: AppColors.text, height: 2),
      labelLarge: const TextStyle().copyWith(color: AppColors.text),
      labelMedium: const TextStyle().copyWith(color: AppColors.text),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.text,
      selectionHandleColor: AppColors.text,
      selectionColor: AppColors.text.withValues(alpha: 0.2),
    ),
    iconTheme: const IconThemeData(color: AppColors.primary),
  );
}
