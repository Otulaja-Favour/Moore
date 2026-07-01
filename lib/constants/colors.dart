import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Brand ──────────────────────────────────────────────
  static const Color primary       = Color(0xFF2F54EB); // Moore primary blue
  static const Color accent        = Color(0xFF597EF7); // Accent / lighter blue

  // ── Onboarding ─────────────────────────────────────────
  static const Color onboardingBg        = Color(0xFF3355E0); // solid mid-blue screen bg
  static const Color onboardingBgDark    = Color(0xFF1A2FA0); // darker navy bottom overlay
  static const Color onboardingContainer = Color(0xFF2244CC); // button area container
  static const Color onboardingBtnOpen   = Color(0xFF3B6BF5); // "Open account" solid btn

  // ── Gradient (used in auth screens + passcode) ─────────
  static const Color gradientStart = Color(0xFF4A6CF7); // top-left lighter blue
  static const Color gradientEnd   = Color(0xFF091442); // bottom-right deep navy

  // ── Backgrounds ────────────────────────────────────────
  static const Color splashBackground = Colors.white;
  static const Color cardBackground   = Colors.white;

  // ── Text on light backgrounds ──────────────────────────
  static const Color textDarkPrimary     = Color(0xFF0F172A); // near-black
  static const Color textDarkSecondary   = Color(0xFF475569); // slate gray
  static const Color textDarkPlaceholder = Color(0xFF94A3B8); // muted gray
  static const Color textBlue            = Color(0xFF2F54EB); // link / highlight

  // ── Text on dark/gradient backgrounds ──────────────────
  static const Color textLightPrimary   = Colors.white;
  static const Color textLightSecondary = Color(0xE6FFFFFF); // 90% white
  static const Color textLightMuted     = Color(0xB3FFFFFF); // 70% white

  // ── Borders ────────────────────────────────────────────
  static const Color borderLight       = Color(0xFFE2E8F0); // input borders
  static const Color borderDarkOutline = Colors.white54;    // outlined btn on dark bg
}
