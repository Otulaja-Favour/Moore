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
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ── Row 1: back arrow  |  logo + "Moore" ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back arrow or empty space
              if (showBackButton)
                GestureDetector(
                  onTap: onBackPressed ?? () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.textLightPrimary,
                    size: 22,
                  ),
                )
              else
                const SizedBox(width: 22),

              // Logo image + "Moore" label
              if (showLogo)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.logo3,
                      height: 28,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                    ),
                    const SizedBox(width: 6),
                    const MooreText(
                      'Moore',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textLightPrimary,
                      letterSpacing: 0.3,
                    ),
                  ],
                )
              else
                const SizedBox.shrink(),
            ],
          ),

          const SizedBox(height: 20),

          // ── Row 2: title  |  step counter ──
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title
              Expanded(
                child: MooreText(
                  title,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textLightPrimary,
                ),
              ),

              // Step counter
              if (currentStep != null && totalSteps != null) ...[
                const SizedBox(width: 12),
                MooreText(
                  'Step $currentStep of $totalSteps',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textLightMuted,
                ),
              ],
            ],
          ),

          // ── Row 3: subtitle ──
          if (subtitle != null && subtitle!.isNotEmpty) ...[
            const SizedBox(height: 6),
            MooreText(
              subtitle!,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textLightSecondary,
            ),
          ],
        ],
      ),
    );
  }
}
