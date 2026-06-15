import 'package:flutter/material.dart';

class AppConstants {
  static const String appTitle = "Pip's Story\nAdventure";
  static const String readMeButtonText = "Read Me A Story";
  static const String loadingText = "Preparing Story";
  static const String loadingSubText = "Pip is gathering some magic dust and turning gears to build your next adventure!";
  static const String errorText = "Oops! Pip couldn't tell the story right now.";
  static const String retryButtonText = "Retry";
  static const String successText = "You Found Pip's Gear!";
  static const String wrongAnswerText = "Almost! Let's try again.";
  static const String quizLockedText = "Quiz Unlocks After Story";
  static const String quizLockedSubText = "Test your memory and earn a reward star.";
  
  // Animation Durations
  static const Duration animationDurationFast = Duration(milliseconds: 300);
  static const Duration animationDurationMedium = Duration(milliseconds: 500);
  static const Duration animationDurationSlow = Duration(milliseconds: 800);

  // Layout Constants
  static const double borderRadiusLarge = 24.0;
  static const double borderRadiusMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingMedium = 16.0;
  static const double paddingSmall = 8.0;
}
