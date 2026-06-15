import 'package:flutter/material.dart';

class AppTheme {
  // Brand Colors based on the provided design
  static const Color primaryBlue = Color(0xFF67C2F1); // Header and light blue accents
  static const Color backgroundLight = Color(0xFFF4F7FA); // App background
  static const Color primaryYellow = Color(0xFFFBD44B); // Main buttons, star pill, icon bgs
  static const Color buttonDarkShadow = Color(0xFFB5931D); // Dark yellow/brown for button bottom shadow
  static const Color textDarkBlue = Color(0xFF28567A); // Primary text color for titles
  static const Color textGray = Color(0xFF627382); // Secondary text color
  static const Color cardBackground = Colors.white; // Mission and story cards
  static const Color cardOutline = Color(0xFF4DB0E6); // Story card blue outline
  static const Color progressBackground = Color(0xFFE2E9EF);
  static const Color successGreen = Color(0xFF55C793); // Success/correct answer color

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        background: backgroundLight,
        surface: cardBackground,
      ),
      // Assuming Nunito or similar rounded font for a child-friendly look.
      // We will rely on default font here but style it to match.
      fontFamily: 'Nunito', 
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: textDarkBlue,
        ),
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textDarkBlue,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textDarkBlue,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textGray,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: textGray,
        ),
        labelLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textDarkBlue,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
