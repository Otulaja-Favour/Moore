// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:moove/components/auth_header.dart';
import 'package:moove/components/custom_button.dart';
import 'package:moove/components/custom_text.dart';
import 'package:moove/constants/assets.dart';
import 'package:moove/constants/colors.dart';
import 'package:moove/screens/login_flow_screens.dart';

import 'package:moove/components/numeric_keypad.dart';

class SecurityQuestionScreen extends StatefulWidget {
  final String phoneNumber;
  const SecurityQuestionScreen({super.key, required this.phoneNumber});

  @override
  State<SecurityQuestionScreen> createState() => _SecurityQuestionScreenState();
}

class _SecurityQuestionScreenState extends State<SecurityQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _answerController = TextEditingController();
  
  final List<String> _questions = [
    'What primary school did you attend?',
    'What is your mother\'s maiden name?',
    'What was the name of your first pet?',
    'In what city were you born?',
  ];
  
  late String _selectedQuestion;

  @override
  void initState() {
    super.initState();
    _selectedQuestion = _questions[0];
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  void _handleProceed() {
    if (_formKey.currentState!.validate()) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: _OtpBottomSheetFlow(
                phoneNumber: widget.phoneNumber,
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header
            const AuthHeader(
              title: 'Answer Security Question',
              showLogo: true,
            ),
            const SizedBox(height: 12),
            // White Container (Form Section)
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        // Explanation Text
                        Container(
                          padding: const EdgeInsets.all(14.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            border: Border.all(color: AppColors.borderLight),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const MooreText(
                            'To proceed, please answer a security question you set during your account creation and we will send a 6 digit passcode to your registered email/phone number.',
                            fontSize: 13,
                            height: 1.5,
                            color: AppColors.textDarkSecondary,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Security Question Label
                        const MooreText(
                          'Security question',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDarkPrimary,
                        ),
                        const SizedBox(height: 8),
                        // Dropdown Button Form Field
                        DropdownButtonFormField<String>(
                          value: _selectedQuestion,
                          isExpanded: true,
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: AppColors.textDarkPrimary,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: AppColors.borderLight),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: AppColors.borderLight),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                            ),
                          ),
                          icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
                          items: _questions.map((String question) {
                            return DropdownMenuItem<String>(
                              value: question,
                              child: Text(question),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedQuestion = newValue;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 24),
                        // Answer Label
                        const MooreText(
                          'Your answer',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDarkPrimary,
                        ),
                        const SizedBox(height: 8),
                        // Answer Text Input
                        TextFormField(
                          controller: _answerController,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(fontFamily: 'Montserrat', fontSize: 15),
                          decoration: InputDecoration(
                            hintText: 'Your answer',
                            hintStyle: const TextStyle(
                              fontFamily: 'Montserrat', 
                              color: AppColors.textDarkPlaceholder,
                              fontSize: 14,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: AppColors.borderLight),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: AppColors.borderLight),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                            ),
                            errorStyle: const TextStyle(fontFamily: 'Montserrat'),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your answer';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 48),
                        // Proceed Button
                        MooreButton(
                          text: 'Proceed',
                          onPressed: _handleProceed,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OtpBottomSheetFlow extends StatefulWidget {
  final String phoneNumber;
  const _OtpBottomSheetFlow({required this.phoneNumber});

  @override
  State<_OtpBottomSheetFlow> createState() => _OtpBottomSheetFlowState();
}

class _OtpBottomSheetFlowState extends State<_OtpBottomSheetFlow> {
  // Pure string list — no TextFormField, no system keyboard
  final List<String> _digits = ['', '', '', ''];
  bool _isCodeInvalid = false;

  static const int _length = 4;

  void _onKeyTap(String value) {
    final idx = _digits.indexWhere((d) => d.isEmpty);
    if (idx == -1) return;
    setState(() {
      _digits[idx] = value;
      _isCodeInvalid = false;
    });
  }

  void _onBackspace() {
    for (int i = _length - 1; i >= 0; i--) {
      if (_digits[i].isNotEmpty) {
        setState(() {
          _digits[i] = '';
          _isCodeInvalid = false;
        });
        return;
      }
    }
  }

  void _handleProceed() {
    final otp = _digits.join();
    if (otp.length < _length) {
      setState(() => _isCodeInvalid = true);
      return;
    }
    if (otp == '1234') {
      Navigator.pop(context); // close OTP sheet
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: false,
        builder: (_) => _DeviceLinkedSheet(
          onProceed: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const ActivateBiometricsScreen(),
              ),
            );
          },
        ),
      );
    } else {
      setState(() {
        _isCodeInvalid = true;
        for (int i = 0; i < _length; i++) {
          _digits[i] = '';
        }
      });
    }
  }

  void _handleTryAgain() {
    setState(() {
      for (int i = 0; i < _length; i++) {
        _digits[i] = '';
      }
      _isCodeInvalid = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 4,
          margin: const EdgeInsets.only(top: 12, bottom: 8),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Expanded(child: _buildOtpContent(context)),
      ],
    );
  }

  Widget _buildOtpContent(BuildContext context) {
    // Mask the phone number
    String masked = widget.phoneNumber;
    final digits = widget.phoneNumber.replaceAll(RegExp(r'\D'), '');
    if (digits.length >= 7) {
      masked = '+${digits.substring(0, 5)}****${digits.substring(digits.length - 3)}';
    }

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.06),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock_person_outlined,
                    color: AppColors.primary,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 16),
                const MooreText(
                  'Verify OTP',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDarkPrimary,
                ),
                const SizedBox(height: 8),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 13,
                      color: AppColors.textDarkSecondary,
                    ),
                    children: [
                      const TextSpan(text: 'We sent a 4 digit code to '),
                      TextSpan(
                        text: masked,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDarkPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const MooreText(
                    'Test OTP: 1234',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 20),
                // OTP display boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(_length, (i) {
                    final filled = _digits[i].isNotEmpty;
                    final borderColor = _isCodeInvalid
                        ? Colors.red
                        : filled
                            ? AppColors.primary
                            : AppColors.borderLight;
                    return Container(
                      width: (MediaQuery.of(context).size.width - 48 - 36) / 4,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: borderColor,
                          width: filled || _isCodeInvalid ? 1.5 : 1.0,
                        ),
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: MooreText(
                        _digits[i],
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: _isCodeInvalid ? Colors.red : AppColors.textDarkPrimary,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Opacity(
                      opacity: _isCodeInvalid ? 1.0 : 0.0,
                      child: const MooreText(
                        'Invalid code',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                    GestureDetector(
                      onTap: _handleTryAgain,
                      child: const MooreText(
                        'Resend code',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                MooreButton(text: 'Proceed', onPressed: _handleProceed),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        // Numeric keypad
        const Divider(height: 1, color: AppColors.borderLight),
        const SizedBox(height: 4),
        NumericKeypad(
          onKeyTap: _onKeyTap,
          onBackspace: _onBackspace,
          showSubLabels: false,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Device Linked Successfully bottom sheet
// ─────────────────────────────────────────────
class _DeviceLinkedSheet extends StatelessWidget {
  final VoidCallback onProceed;
  const _DeviceLinkedSheet({required this.onProceed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 36),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          // Balloon image
          Image.asset(
            AppAssets.congratulation,
            height: 130,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) =>
                const Text('🎉', style: TextStyle(fontSize: 56)),
          ),
          const SizedBox(height: 16),

          const MooreText(
            'Device Linked Successfully',
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.textDarkPrimary,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const MooreText(
            'This device has been set as your primary device.',
            fontSize: 13,
            color: AppColors.textDarkSecondary,
            textAlign: TextAlign.center,
            height: 1.5,
          ),
          const SizedBox(height: 28),

          MooreButton(text: 'Proceed', onPressed: onProceed),
        ],
      ),
    );
  }
}
