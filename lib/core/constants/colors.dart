import 'package:flutter/material.dart';

abstract class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFF4F4F4);
  static const Color onPrimary = Color(0xFF242424);
  static const Color scaffoldBackground = Color(0xFF5F5F5F);

  static const Color text = Color(0xFFF4F4F4);
  static const Color inverseText = Color(0xFF242424);

  static const Color weatherIconBg = Color(0xFF2B2B2B);
  static const Color divider = Color(0x99F4F4F4);
  static const Color transparent = Colors.transparent;
  
  static const Color splashColor = Color(0x59F4F4F4); 

  static const Color glassBg = Color(0x735C5C5C);
  static const Color opaqueGlassBg = Color(0xFF7E7E7E);
  
  static const LinearGradient glassGradient = LinearGradient(
    colors: [
      Color(0x66FFFFFF),
      Color(0x26FFFFFF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}