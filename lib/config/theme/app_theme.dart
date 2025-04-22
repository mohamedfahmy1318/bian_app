import 'package:film/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'SpaceGrotesk',
    scaffoldBackgroundColor: const Color(0xff121312),
    primaryColor: AppColors.primaryColor,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryColor,
      secondary: Colors.white,
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(
        color: AppColors.primaryColor,
      ),
      bodyMedium: TextStyle(color: AppColors.primaryColor),
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xff121312),
      iconTheme: IconThemeData(color: AppColors.primaryColor),
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xffffffff),
    primaryColor: Colors.blue,
    textTheme: const TextTheme(
      bodySmall: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black87),
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.blue,
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );
}
