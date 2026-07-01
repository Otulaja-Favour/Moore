// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moove/components/custom_button.dart';
import 'package:moove/components/custom_text.dart';
import 'package:moove/constants/assets.dart';
import 'package:moove/constants/colors.dart';
import 'package:moove/screens/next_steps_screen.dart';

/// Profile Screen 1 — "How to Fund Your Account"
/// Shown after Congratulations → Login button
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Welcome illustration ──
            SizedBox(
              width: double.infinity,
              height: 220,
              child: SvgPicture.asset(
                AppAssets.welcome,
                fit: BoxFit.contain,
                placeholderBuilder: (_) => Container(
                  height: 220,
                  color: const Color(0xFFF0F4FF),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2,
                    ),
                  ),
                ),
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

                    // How to Fund card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F4FF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MooreText(
                            'How to Fund Your Account',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDarkPrimary,
                          ),
                          const SizedBox(height: 10),
                          const MooreText(
                            'To deposit money into your MOORE wallet, transfer funds using the details above from any Nigerian bank or fintech app.',
                            fontSize: 13,
                            color: AppColors.textDarkSecondary,
                            height: 1.55,
                          ),
                          const SizedBox(height: 16),

                          // Bank name row
                          _infoRow('Xpresswallet'),
                          const SizedBox(height: 8),

                          // Account number row
                          Row(
                            children: [
                              const Icon(Icons.account_balance_outlined,
                                  size: 16, color: AppColors.primary),
                              const SizedBox(width: 8),
                              const MooreText(
                                '005 302 2025',
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textDarkPrimary,
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {},
                                child: const MooreText(
                                  'Copy',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textBlue,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Account name row
                          _infoRow('Oluwabunmi Okafor'),
                          const SizedBox(height: 10),

                          // Note
                          const MooreText(
                            'You can see this account details by clicking the "Add money" button on your dashboard and selecting "Fund with Other banks".',
                            fontSize: 12,
                            color: AppColors.textDarkSecondary,
                            height: 1.5,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // ── Continue button ──
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: MooreButton(
                text: 'Continue',
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const NextStepsScreen()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String text) {
    return Row(
      children: [
        const Icon(Icons.info_outline, size: 14, color: AppColors.textDarkSecondary),
        const SizedBox(width: 6),
        MooreText(
          text,
          fontSize: 13,
          color: AppColors.textDarkSecondary,
        ),
      ],
    );
  }
}
