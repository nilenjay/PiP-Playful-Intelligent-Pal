import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF6C63FF); // Vibrant Purple
  static const Color secondaryColor = Color(0xFFFFB86C); // Bright Orange
  static const Color backgroundColor = Color(0xFFF8F9FA); // Soft White
  static const Color surfaceColor = Colors.white;
  static const Color textPrimaryColor = Color(0xFF2D3436); // Dark Gray
  static const Color textSecondaryColor = Color(0xFF636E72); // Medium Gray
  static const Color successColor = Color(0xFF00B894); // Green
  static const Color errorColor = Color(0xFFFF7675); // Soft Red

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        background: backgroundColor,
        surface: surfaceColor,
        error: errorColor,
      ),
      fontFamily: 'Nunito', // A friendly rounded font, ideally added to pubspec, using default for now or assuming it will fallback gracefully.
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: textPrimaryColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimaryColor,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textSecondaryColor,
        ),
        labelLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
      cardTheme: CardTheme(
        color: surfaceColor,
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }
}
