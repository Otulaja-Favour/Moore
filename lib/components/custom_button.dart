import 'package:flutter/material.dart';
import 'package:moove/components/custom_text.dart';
import 'package:moove/constants/colors.dart';

class MooreButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double width;
  final double height;
  final double borderRadius;

  const MooreButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.width = double.infinity,
    this.height = 54.0,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTextColor = isOutlined 
        ? AppColors.textLightPrimary 
        : AppColors.textLightPrimary;

    final defaultBgColor = isOutlined 
        ? Colors.transparent 
        : AppColors.primary;

    final defaultBorderColor = isOutlined 
        ? AppColors.borderDarkOutline 
        : Colors.transparent;

    return SizedBox(
      width: width,
      height: height,
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                backgroundColor: backgroundColor ?? defaultBgColor,
                side: BorderSide(
                  color: borderColor ?? defaultBorderColor,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: MooreText(
                text,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor ?? defaultTextColor,
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor ?? defaultBgColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: MooreText(
                text,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor ?? defaultTextColor,
              ),
            ),
    );
  }
}
