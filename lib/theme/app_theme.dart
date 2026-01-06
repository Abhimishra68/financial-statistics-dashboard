import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBackground = Color(0xFF1A0A3D);
  static const Color cardBackground = Color(0xFF2D1B5E);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA0A0A0);
  static const Color accentRed = Color(0xFFFF456B);
  static const Color accentOrange = Color(0xFFFF8C42);
  static const Color accentYellow = Color(0xFFFFD700);
  static const Color accentBlue = Color(0xFF6495ED);
  static const Color accentDarkBlue = Color(0xFF4169E1);
  static const Color accentPurple = Color(0xFF9370DB);
  static const Color accentPink = Color(0xFFFF69B4);
  static const Color accentLightOrange = Color(0xFFFFA07A);
  static const Color accentWhite = Color(0xFFE8E8E8);
  static const Color borderColor = Color(0xFF6A5ACD);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: accentRed,
      scaffoldBackgroundColor: primaryBackground,
      useMaterial3: true,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: textPrimary,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: textSecondary,
          fontSize: 14,
        ),
      ),
    );
  }
}
