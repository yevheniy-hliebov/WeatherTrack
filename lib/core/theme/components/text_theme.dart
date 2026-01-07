part of '../theme.dart';

abstract class AppTextTheme {
  const AppTextTheme._();

  static TextTheme get text => TextTheme(
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
  );

  static TextSelectionThemeData get textSelection => TextSelectionThemeData(
    cursorColor: AppColors.text,
    selectionHandleColor: AppColors.text,
    selectionColor: AppColors.text.withValues(alpha: 0.2),
  );
}
