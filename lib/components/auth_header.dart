// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:moove/components/custom_text.dart';
import 'package:moove/constants/assets.dart';
import 'package:moove/constants/colors.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final int? currentStep;
  final int? totalSteps;
  final VoidCallback? onBackPressed;
  final bool showLogo;

  /// Set to false on root screens (Login, SignUp) where there's nothing to go back to.
  final bool showBackButton;

  const AuthHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.currentStep,
    this.totalSteps,
    this.onBackPressed,
    this.showLogo = true,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Arrow + Text Titles
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showBackButton) ...[
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: onBackPressed ?? () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MooreText(
                        title,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textLightPrimary,
                      ),
                      if (subtitle != null && subtitle!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        MooreText(
                          subtitle!,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textLightSecondary.withOpacity(0.85),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Step counter + logo
          if (showLogo || (currentStep != null && totalSteps != null))
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (currentStep != null && totalSteps != null)
                  MooreText(
                    'Step $currentStep of $totalSteps',
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textLightMuted,
                  ),
                if (showLogo) ...[
                  if (currentStep != null && totalSteps != null)
                    const SizedBox(height: 6),
                  Image.asset(
                    AppAssets.logo,
                    height: 28,
                    fit: BoxFit.contain,
                  ),
                ],
              ],
            ),
        ],
      ),
    );
  }
}
