import 'package:flutter/material.dart';
import 'package:moove/components/custom_text.dart';
import 'package:moove/constants/colors.dart';

/// Reusable phone-style numeric keypad.
/// Used on OTP screens (white bg, dark keys) and passcode screens (handled separately).
class NumericKeypad extends StatelessWidget {
  final void Function(String) onKeyTap;
  final VoidCallback onBackspace;

  /// Optional bottom-left label (e.g. "Reset"). Null = empty space.
  final String? bottomLeftLabel;
  final VoidCallback? onBottomLeftTap;

  /// Whether to show ABC/DEF sub-labels under digits. False for OTP screens.
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

  Widget _digitKey(String digit) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onKeyTap(digit),
        child: Container(
          height: 60,
          alignment: Alignment.center,
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(children: [_digitKey('1'), _digitKey('2'), _digitKey('3')]),
          Row(children: [_digitKey('4'), _digitKey('5'), _digitKey('6')]),
          Row(children: [_digitKey('7'), _digitKey('8'), _digitKey('9')]),
          Row(
            children: [
              // Bottom-left
              Expanded(
                child: bottomLeftLabel != null
                    ? GestureDetector(
                        onTap: onBottomLeftTap,
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          child: MooreText(
                            bottomLeftLabel!,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDarkSecondary,
                          ),
                        ),
                      )
                    : const SizedBox(height: 60),
              ),
              _digitKey('0'),
              // Backspace
              Expanded(
                child: GestureDetector(
                  onTap: onBackspace,
                  child: const SizedBox(
                    height: 60,
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
