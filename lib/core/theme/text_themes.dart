import 'package:flutter/material.dart';

class AppTextTheme {
  static TextTheme get textTheme {
    return const TextTheme(
      displayLarge: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 57,
        letterSpacing: -0.25,
      ),
      displayMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 45,
        letterSpacing: 0,
      ),
      displaySmall: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 36,
        letterSpacing: 0,
      ),
      headlineLarge: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 32,
        letterSpacing: 0,
      ),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 28,
        letterSpacing: 0,
      ),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 24,
        letterSpacing: 0,
      ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 22,
        letterSpacing: 0,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        letterSpacing: 0.1,
      ),
      labelLarge: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 11,
        letterSpacing: 0.5,
      ),
      bodyLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        letterSpacing: 0.25,
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        letterSpacing: 0.4,
      ),
    );
  }
}
