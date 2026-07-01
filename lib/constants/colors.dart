import 'package:flutter/material.dart';

class AppColors {
  // Prevent instantiation
  AppColors._();

  // Gradient Colors (Onboarding Background)
  static const Color gradientStart = Color(0xFF2F54EB); // Vibrant royal blue
  static const Color gradientEnd = Color(0xFF091442);   // Deep midnight navy

  // Brand Colors
  static const Color primary = Color(0xFF2F54EB);       // Moore Primary Blue
  static const Color accent = Color(0xFF597EF7);        // Accent light blue
  static const Color textBlue = Color(0xFF2F54EB);      // Link / text highlight blue

  // Backgrounds
  static const Color splashBackground = Colors.white;
  static const Color cardBackground = Colors.white;

  // Text colors for light backgrounds
  static const Color textDarkPrimary = Color(0xFF0F172A);   // Near black (e.g. "Sign Up", "Create your account")
  static const Color textDarkSecondary = Color(0xFF475569); // Dark slate gray (labels like "Email Address")
  static const Color textDarkPlaceholder = Color(0xFF94A3B8); // Muted gray (placeholder text)

  // Text colors for dark/gradient backgrounds
  static const Color textLightPrimary = Colors.white;
  static const Color textLightSecondary = Color(0xE6FFFFFF); // 90% opacity white
  static const Color textLightMuted = Color(0xB3FFFFFF);     // 70% opacity white

  // Borders & Dividers
  static const Color borderLight = Color(0xFFE2E8F0);        // Input borders
  static const Color borderDarkOutline = Colors.white54;    // Outlined button border
}
