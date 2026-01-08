part of '../theme.dart';

abstract class AppSearchTheme {
  const AppSearchTheme._();

  static final TextTheme _textTheme = AppTextTheme.text;

  static SearchBarThemeData get bar => SearchBarThemeData(
    backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
    elevation: const WidgetStatePropertyAll(0),
    constraints: const BoxConstraints(),
    hintStyle: WidgetStatePropertyAll(_textTheme.bodyLarge),
    textStyle: WidgetStatePropertyAll(_textTheme.bodyLarge),
    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
    shadowColor: const WidgetStatePropertyAll(Colors.transparent),
    shape: const WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide.none,
      ),
    ),
    side: const WidgetStatePropertyAll(BorderSide.none),
    surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
    padding: const WidgetStatePropertyAll(
      EdgeInsets.symmetric(horizontal: Spacing.sm, vertical: Spacing.xs),
    ),
  );

  static MenuThemeData get menu => const MenuThemeData(
    style: MenuStyle(
      backgroundColor: WidgetStatePropertyAll(Colors.transparent),
      elevation: WidgetStatePropertyAll(0),
      shadowColor: WidgetStatePropertyAll(Colors.transparent),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide.none,
        ),
      ),
      side: WidgetStatePropertyAll(BorderSide.none),
    ),
  );
}
