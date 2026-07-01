// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moove/components/custom_button.dart';
import 'package:moove/components/custom_text.dart';
import 'package:moove/constants/assets.dart';
import 'package:moove/constants/colors.dart';
import 'package:moove/screens/dashboard_screen.dart';

/// Profile Screen 2 — "Next Steps"
/// Shown after WelcomeScreen → Continue
class NextStepsScreen extends StatelessWidget {
  const NextStepsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Illustration (same welcome.svg) ──
            SvgPicture.asset(
              AppAssets.welcome,
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
              placeholderBuilder: (_) => Container(
                height: 220,
                color: const Color(0xFFF0F4FF),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MooreText(
                      'Welcome to Moore!',
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDarkPrimary,
                    ),
                    const SizedBox(height: 4),
                    const MooreText(
                      'Your account is ready.',
                      fontSize: 14,
                      color: AppColors.textDarkSecondary,
                    ),
                    const SizedBox(height: 24),

                    // Next Steps card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MooreText(
                            'Next Steps',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDarkPrimary,
                          ),
                          const SizedBox(height: 14),
                          _step('Start making payments & transfers'),
                          _step('Buy airtime, data, and pay bills'),
                          _step(
                              'Enjoy amazing cashback on your airtime, data, power purchases and other bills.'),
                          _step(
                              'If you have any questions, contact MOORE Support via in-app chat and Whatsapp messages 234906300622.'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // ── Buttons ──
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: MooreButton(
                text: 'Continue to Dashboard',
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const DashboardScreen()),
                  (route) => false,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: MooreButton(
                text: 'Upgrade Account',
                isOutlined: true,
                textColor: AppColors.primary,
                borderColor: AppColors.primary,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _step(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 5, right: 10),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
          ),
          Expanded(
            child: MooreText(
              text,
              fontSize: 13,
              color: AppColors.textDarkSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
