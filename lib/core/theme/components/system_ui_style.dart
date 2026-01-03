import 'package:flutter/services.dart';
import 'package:weathertrack/core/constants/colors.dart';

class SystemUiStyle {
  SystemUiStyle._();

  static void configure() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent, 
        statusBarIconBrightness: Brightness.dark, 
        statusBarBrightness: Brightness.light,   

        systemNavigationBarColor: AppColors.scaffoldBackground, 
        systemNavigationBarIconBrightness: Brightness.dark,
       
        systemNavigationBarDividerColor: AppColors.transparent, 
      ),
    );
  }
}