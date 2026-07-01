// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:moove/components/custom_button.dart';
import 'package:moove/components/custom_text.dart';
import 'package:moove/constants/colors.dart';
import 'package:moove/screens/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Greeting
              const MooreText(
                'Welcome to Moore!',
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppColors.textDarkPrimary,
              ),
              const SizedBox(height: 8),
              const MooreText(
                'Your account is ready.',
                fontSize: 15,
                color: AppColors.textDarkSecondary,
              ),
              const SizedBox(height: 32),

              // How to fund card
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
                    const SizedBox(height: 12),
                    const MooreText(
                      'To deposit money into your MOORE wallet, transfer funds using your Moore account number or the Moore app.',
                      fontSize: 13,
                      color: AppColors.textDarkSecondary,
                      height: 1.55,
                    ),
                    const SizedBox(height: 16),
                    // Account number chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: AppColors.borderLight),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.account_balance_wallet_outlined,
                              size: 16, color: AppColors.primary),
                          const SizedBox(width: 8),
                          const MooreText(
                            '0001 332 1234',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDarkPrimary,
                          ),
                          const SizedBox(width: 12),
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
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Next steps card
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
                    const SizedBox(height: 12),
                    _step(Icons.send_outlined,
                        'Start making payments & transfers'),
                    _step(Icons.person_outline,
                        'Buy airtime, data, and pay bills'),
                    _step(Icons.support_agent_outlined,
                        'If you have any questions, contact MOORE Support via the app and Whatsapp messages.'),
                  ],
                ),
              ),

              const Spacer(),

              MooreButton(
                text: 'Continue to Dashboard',
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: 12),
              MooreButton(
                text: 'Upgrade Account',
                isOutlined: true,
                textColor: AppColors.primary,
                borderColor: AppColors.primary,
                onPressed: () {},
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _step(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: MooreText(
              text,
              fontSize: 13,
              color: AppColors.textDarkSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
