// ignore_for_file: deprecated_member_use
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:moove/components/auth_header.dart';
import 'package:moove/components/custom_button.dart';
import 'package:moove/components/custom_text.dart';
import 'package:moove/components/numeric_keypad.dart';
import 'package:moove/constants/colors.dart';
import 'package:moove/screens/verify_bvn_nin_screen.dart';
import 'package:moove/utils/validators.dart';

class VerifyPhoneOtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String email;

  const VerifyPhoneOtpScreen({
    super.key,
    required this.phoneNumber,
    required this.email,
  });

  @override
  State<VerifyPhoneOtpScreen> createState() => _VerifyPhoneOtpScreenState();
}

class _VerifyPhoneOtpScreenState extends State<VerifyPhoneOtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  bool _hasError = false;
  String _errorMessage = '';
  int _secondsRemaining = 59;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsRemaining = 59);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsRemaining == 0) {
        t.cancel();
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  String _maskedPhone(String phone) {
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 7) return '+$digits';
    final prefix = digits.substring(0, 5);
    final suffix = digits.substring(digits.length - 3);
    return '+${prefix}****$suffix';
  }

  String get _otp => _controllers.map((c) => c.text).join();

  void _onKeyTap(String value) {
    for (int i = 0; i < _controllers.length; i++) {
      if (_controllers[i].text.isEmpty) {
        setState(() {
          _controllers[i].text = value;
          _hasError = false;
        });
        return;
      }
    }
  }

  void _onBackspace() {
    for (int i = _controllers.length - 1; i >= 0; i--) {
      if (_controllers[i].text.isNotEmpty) {
        setState(() {
          _controllers[i].clear();
          _hasError = false;
        });
        return;
      }
    }
  }

  void _handleProceed() {
    // Validate OTP completeness
    final error = AppValidators.otp(_otp);
    if (error != null) {
      setState(() {
        _hasError = true;
        _errorMessage = error;
      });
      return;
    }
    // Mock OTP check — in production this would be verified server-side
    if (_otp != '1234') {
      setState(() {
        _hasError = true;
        _errorMessage = 'Invalid code. Please try again';
      });
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => VerifyBvnNinScreen(
          phoneNumber: widget.phoneNumber,
          email: widget.email,
        ),
      ),
    );
  }

  void _handleResend() {
    for (var c in _controllers) {
      c.clear();
    }
    setState(() {
      _hasError = false;
      _errorMessage = '';
    });
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final masked = _maskedPhone(widget.phoneNumber);
    final timerText =
        'Code expires in: 0${_secondsRemaining ~/ 60}:${(_secondsRemaining % 60).toString().padLeft(2, '0')}';

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AuthHeader(
              title: 'Verify Phone Number',
              subtitle: 'Verify the phone number linked to your BVN',
              currentStep: 2,
              totalSteps: 5,
              onBackPressed: () => Navigator.pop(context),
            ),
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
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                  color: AppColors.textDarkSecondary,
                                ),
                                children: [
                                  const TextSpan(
                                      text: 'We sent a 4 digit code to '),
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
                            // Dev hint — remove in production
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
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
                            const SizedBox(height: 32),

                            // OTP boxes
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(4, (i) {
                                final filled = _controllers[i].text.isNotEmpty;
                                final borderColor = _hasError
                                    ? Colors.red
                                    : filled
                                        ? AppColors.primary
                                        : AppColors.borderLight;
                                return Container(
                                  width:
                                      (MediaQuery.of(context).size.width -
                                              48 -
                                              36) /
                                          4,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: borderColor,
                                      width: filled || _hasError ? 1.5 : 1.0,
                                    ),
                                    color: Colors.white,
                                  ),
                                  alignment: Alignment.center,
                                  child: MooreText(
                                    _controllers[i].text,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: _hasError
                                        ? Colors.red
                                        : AppColors.textDarkPrimary,
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 12),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _hasError
                                    ? MooreText(
                                        _errorMessage,
                                        fontSize: 12,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
                                      )
                                    : MooreText(
                                        timerText,
                                        fontSize: 12,
                                        color: AppColors.textDarkSecondary,
                                      ),
                                GestureDetector(
                                  onTap: _secondsRemaining == 0
                                      ? _handleResend
                                      : null,
                                  child: MooreText(
                                    'Resend code',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: _secondsRemaining == 0
                                        ? AppColors.textBlue
                                        : AppColors.textDarkPlaceholder,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),

                            MooreButton(
                              text: 'Proceed',
                              onPressed: _handleProceed,
                            ),
                            const SizedBox(height: 24),

                            Center(
                              child: TextButton(
                                onPressed: () => Navigator.of(context)
                                    .popUntil((r) => r.isFirst),
                                child: const MooreText(
                                  'I already have an account',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    NumericKeypad(
                      onKeyTap: _onKeyTap,
                      onBackspace: _onBackspace,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
