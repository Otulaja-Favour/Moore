import 'package:flutter/material.dart';
import 'package:moove/components/custom_text.dart';
import 'package:moove/constants/colors.dart';

/// Reusable numeric keypad where every key is a proper tappable button.
class NumericKeypad extends StatelessWidget {
  final void Function(String) onKeyTap;
  final VoidCallback onBackspace;
  final String? bottomLeftLabel;
  final VoidCallback? onBottomLeftTap;
  final bool showSubLabels;

  const NumericKeypad({
    super.key,
    required this.onKeyTap,
    required this.onBackspace,
    this.bottomLeftLabel,
    this.onBottomLeftTap,
    this.showSubLabels = false,
  });

  static const Map<String, String> _subLabels = {
    '2': 'ABC',
    '3': 'DEF',
    '4': 'GHI',
    '5': 'JKL',
    '6': 'MNO',
    '7': 'PQRS',
    '8': 'TUV',
    '9': 'WXYZ',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _row(['1', '2', '3']),
          _row(['4', '5', '6']),
          _row(['7', '8', '9']),
          Row(
            children: [
              // Bottom-left: optional label or empty spacer
              Expanded(
                child: bottomLeftLabel != null
                    ? _actionBtn(
                        onTap: onBottomLeftTap ?? () {},
                        child: MooreText(
                          bottomLeftLabel!,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDarkSecondary,
                        ),
                      )
                    : const SizedBox(height: 64),
              ),
              Expanded(child: _digitBtn('0')),
              // Backspace
              Expanded(
                child: _actionBtn(
                  onTap: onBackspace,
                  child: const Icon(
                    Icons.backspace_outlined,
                    color: AppColors.textDarkPrimary,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _row(List<String> digits) {
    return Row(
      children: digits.map((d) => Expanded(child: _digitBtn(d))).toList(),
    );
  }

  Widget _digitBtn(String digit) {
    return _actionBtn(
      onTap: () => onKeyTap(digit),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MooreText(
            digit,
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: AppColors.textDarkPrimary,
          ),
          if (showSubLabels && _subLabels[digit] != null)
            MooreText(
              _subLabels[digit]!,
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: AppColors.textDarkSecondary,
              letterSpacing: 1.2,
            ),
        ],
      ),
    );
  }

  Widget _actionBtn({required VoidCallback onTap, required Widget child}) {
    return SizedBox(
      height: 64,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary.withOpacity(0.12),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          overlayColor: AppColors.primary,
        ),
        child: child,
      ),
    );
  }
}
