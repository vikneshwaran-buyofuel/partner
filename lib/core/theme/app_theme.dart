import 'package:flutter/material.dart';
import 'package:partner/core/constants/app_colors.dart';


class AppTheme {
  /// 🌞 Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    fontFamily: 'Inter',
    textTheme: _textTheme(AppColors.black),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.black,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
        fontFamily: 'Inter',
      ),
    ),
  );

  /// 🌚 Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.primary,
    fontFamily: 'Inter',
    textTheme: _textTheme(AppColors.white),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
        fontFamily: 'Inter',
      ),
    ),
  );

  /// 🧩 Material Design 3 Text Theme Generator
  static TextTheme _textTheme(Color color) {
    return TextTheme(
      // Display styles - Largest text, reserved for short, important text
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: color,
        letterSpacing: -0.25,
        height: 64 / 57,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: color,
        letterSpacing: 0,
        height: 52 / 45,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: color,
        letterSpacing: 0,
        height: 44 / 36,
      ),

      // Headlines - For high-emphasis text
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        color: color,
        letterSpacing: 0,
        height: 40 / 32,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: color,
        letterSpacing: 0,
        height: 36 / 28,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: color,
        letterSpacing: 0,
        height: 32 / 24,
      ),

      // Titles - For medium-emphasis text
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: color,
        letterSpacing: 0,
        height: 28 / 22,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 0.15,
        height: 24 / 16,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 0.1,
        height: 20 / 14,
      ),

      // Body - Default text styles
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color,
        letterSpacing: 0.5,
        height: 24 / 16,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
        letterSpacing: 0.25,
        height: 20 / 14,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color,
        letterSpacing: 0.4,
        height: 16 / 12,
      ),
      
      // Labels - For buttons, tabs, and other UI elements
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 0.1,
        height: 20 / 14,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 0.5,
        height: 16 / 12,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 0.5,
        height: 16 / 11,
      ),
    );
  }
}

/// 🧠 Extra Custom Styles Extension
extension ExtraTextStyles on TextTheme {
  TextStyle get displayExtraLarge => TextStyle(
    fontSize: 64,
    fontWeight: FontWeight.w400,
    color: bodyLarge?.color,
    letterSpacing: -0.25,
    height: 72 / 64,
  );

  TextStyle get caption => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: bodySmall?.color?.withOpacity(0.6),
    letterSpacing: 0.4,
    height: 16 / 12,
  );
}