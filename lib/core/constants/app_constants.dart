import 'package:flutter/material.dart';

class AppConstants {
  static const String appTitle = "Pip's Story Adventure";
  static const String readMeButtonText = "Read Me A Story";
  static const String loadingText = "Pip is getting ready to tell the story...";
  static const String errorText = "Oops! Pip couldn't tell the story right now.";
  static const String retryButtonText = "Retry";
  static const String successText = "You Found Pip's Gear!";
  static const String wrongAnswerText = "Almost! Let's try again.";
  
  // Animation Durations
  static const Duration animationDurationFast = Duration(milliseconds: 300);
  static const Duration animationDurationMedium = Duration(milliseconds: 500);
  static const Duration animationDurationSlow = Duration(milliseconds: 800);

  // Layout Constants
  static const double borderRadius = 24.0;
  static const double paddingLarge = 24.0;
  static const double paddingMedium = 16.0;
  static const double paddingSmall = 8.0;
}
