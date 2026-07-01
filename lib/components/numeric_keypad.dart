import 'package:flutter/material.dart';
import 'package:moove/components/custom_text.dart';
import 'package:moove/constants/colors.dart';

/// Reusable phone-style numeric keypad used across OTP and PIN screens.
class NumericKeypad extends StatelessWidget {
  final void Function(String) onKeyTap;
  final VoidCallback onBackspace;

  /// Optional label for the bottom-left key. Pass null to leave it empty.
  final String? bottomLeftLabel;

  /// Optional callback for the bottom-left key.
  final VoidCallback? onBottomLeftTap;

  const NumericKeypad({
    super.key,
    required this.onKeyTap,
    required this.onBackspace,
    this.bottomLeftLabel,
    this.onBottomLeftTap,
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

  Widget _digitKey(String digit) {
    return Expanded(
      child: InkWell(
        onTap: () => onKeyTap(digit),
        borderRadius: BorderRadius.circular(40),
        child: SizedBox(
          height: 64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MooreText(
                digit,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: AppColors.textDarkPrimary,
              ),
              if (_subLabels[digit] != null)
                MooreText(
                  _subLabels[digit]!,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDarkSecondary,
                  letterSpacing: 1.2,
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Row(children: [_digitKey('1'), _digitKey('2'), _digitKey('3')]),
          Row(children: [_digitKey('4'), _digitKey('5'), _digitKey('6')]),
          Row(children: [_digitKey('7'), _digitKey('8'), _digitKey('9')]),
          Row(
            children: [
              // Bottom-left: optional label or empty
              Expanded(
                child: bottomLeftLabel != null
                    ? InkWell(
                        onTap: onBottomLeftTap,
                        borderRadius: BorderRadius.circular(40),
                        child: SizedBox(
                          height: 64,
                          child: Center(
                            child: MooreText(
                              bottomLeftLabel!,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDarkSecondary,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(height: 64),
              ),
              _digitKey('0'),
              // Backspace
              Expanded(
                child: InkWell(
                  onTap: onBackspace,
                  borderRadius: BorderRadius.circular(40),
                  child: const SizedBox(
                    height: 64,
                    child: Icon(
                      Icons.backspace_outlined,
                      color: AppColors.textDarkPrimary,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
