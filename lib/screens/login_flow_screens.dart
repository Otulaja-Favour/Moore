// ignore_for_file: deprecated_member_use
//
// Contains all login-flow screens after passcode:
//   - UsePrimaryDeviceScreen
//   - ActivateBiometricsScreen
//
// SecurityQuestionScreen already exists in security_question_screen.dart
// and handles the OTP + device binding flow internally.

import 'package:flutter/material.dart';
import 'package:moove/components/custom_button.dart';
import 'package:moove/components/custom_text.dart';
import 'package:moove/constants/colors.dart';
import 'package:moove/screens/security_question_screen.dart';
import 'package:moove/screens/dashboard_screen.dart';

// ═══════════════════════════════════════════════════════════
// USE AS PRIMARY DEVICE
// ═══════════════════════════════════════════════════════════
class UsePrimaryDeviceScreen extends StatelessWidget {
  const UsePrimaryDeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 22),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 24),

                      // Device icon
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.phone_android_outlined,
                          color: AppColors.primary,
                          size: 44,
                        ),
                      ),
                      const SizedBox(height: 24),

                      const MooreText(
                        'Use as Primary Device',
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDarkPrimary,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),

                      const MooreText(
                        'Would you like to register this device as your primary device? This will allow you to access your account quickly and securely.',
                        fontSize: 14,
                        color: AppColors.textDarkSecondary,
                        textAlign: TextAlign.center,
                        height: 1.55,
                      ),

                      const Spacer(),

                      MooreButton(
                        text: 'Proceed',
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SecurityQuestionScreen(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (_) => const DashboardScreen()),
                          (route) => false,
                        ),
                        child: const MooreText(
                          'No thanks',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textBlue,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// ACTIVATE BIOMETRICS
// ═══════════════════════════════════════════════════════════
class ActivateBiometricsScreen extends StatelessWidget {
  const ActivateBiometricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 22),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 24),

                      // Fingerprint icon
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.fingerprint,
                          color: AppColors.primary,
                          size: 50,
                        ),
                      ),
                      const SizedBox(height: 24),

                      const MooreText(
                        'Activate Biometrics',
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDarkPrimary,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),

                      const MooreText(
                        'Enable biometric authentication (fingerprint or face ID) for faster and more secure access to your Moore account.',
                        fontSize: 14,
                        color: AppColors.textDarkSecondary,
                        textAlign: TextAlign.center,
                        height: 1.55,
                      ),

                      const Spacer(),

                      MooreButton(
                        text: 'Activate Biometrics',
                        onPressed: () =>
                            Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (_) => const DashboardScreen()),
                          (route) => false,
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (_) => const DashboardScreen()),
                          (route) => false,
                        ),
                        child: const MooreText(
                          'No thanks',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textBlue,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
