import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Brand ──────────────────────────────────────────────
  static const Color primary = Color(0xFF2F54EB); // Moore primary blue
  static const Color accent  = Color(0xFF597EF7); // Accent / lighter blue

  // ── Onboarding (exact values from color picker) ────────
  static const Color onboardingBg        = Color(0xFF4361EE); // screen background
  static const Color onboardingContainer = Color(0xFF6F94F3); // button area container
  // "Open account" uses onboardingBg (#4361EE) — same as background

  // ── Gradient (auth screens + passcode) ─────────────────
  static const Color gradientStart = Color(0xFF4A6CF7); // top lighter blue
  static const Color gradientEnd   = Color(0xFF091442); // bottom deep navy

  // ── Backgrounds ────────────────────────────────────────
  static const Color splashBackground = Colors.white;
  static const Color cardBackground   = Colors.white;

  // ── Text on light backgrounds ──────────────────────────
  static const Color textDarkPrimary     = Color(0xFF0F172A);
  static const Color textDarkSecondary   = Color(0xFF475569);
  static const Color textDarkPlaceholder = Color(0xFF94A3B8);
  static const Color textBlue            = Color(0xFF2F54EB);

  // ── Text on dark/gradient backgrounds ──────────────────
  static const Color textLightPrimary   = Colors.white;
  static const Color textLightSecondary = Color(0xE6FFFFFF); // 90% white
  static const Color textLightMuted     = Color(0xB3FFFFFF); // 70% white

  // ── Borders ────────────────────────────────────────────
  static const Color borderLight       = Color(0xFFE2E8F0);
  static const Color borderDarkOutline = Colors.white54;
}
