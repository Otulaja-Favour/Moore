// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:moove/constants/colors.dart';

class SupportButton extends StatelessWidget {
  final VoidCallback? onTap;

  const SupportButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Support chat is not available right now.'),
          ),
        );
      },
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.headset_mic_outlined,
          color: Colors.white,
          size: 26,
        ),
      ),
    );
  }
}
