// ignore_for_file: deprecated_member_use
//
// Contains:
//  - VerifyBvnNinScreen  (main form)
//  - _ConfirmPhoneDialog (inline dialog: "Confirm the phone associated with your BVN")
//  - UpdateBvnDetailsScreen (shown when user can't access that number)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moove/components/app_input_field.dart';
import 'package:moove/components/auth_header.dart';
import 'package:moove/components/custom_button.dart';
import 'package:moove/components/custom_text.dart';
import 'package:moove/constants/colors.dart';
import 'package:moove/screens/verify_bvn_otp_screen.dart';
import 'package:moove/utils/validators.dart';

enum _VerifyMode { bvn, nin }

// ═══════════════════════════════════════════════════════════
// VERIFY BVN / NIN SCREEN
// ═══════════════════════════════════════════════════════════
class VerifyBvnNinScreen extends StatefulWidget {
  final String phoneNumber;
  final String email;

  const VerifyBvnNinScreen({
    super.key,
    required this.phoneNumber,
    required this.email,
  });

  @override
  State<VerifyBvnNinScreen> createState() => _VerifyBvnNinScreenState();
}

class _VerifyBvnNinScreenState extends State<VerifyBvnNinScreen> {
  _VerifyMode _mode = _VerifyMode.bvn;

  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();
  final _dobController = TextEditingController();

  // tracks a server-side style BVN validation error
  bool _bvnApiError = false;
  String _bvnApiErrorMessage =
      "Apologies, we can't validate your BVN at this time";

  @override
  void dispose() {
    _numberController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  String get _numberLabel => _mode == _VerifyMode.bvn ? 'BVN' : 'NIN';
  int get _numberLength => 11;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      _dobController.text =
          '${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}';
      setState(() {});
    }
  }

  void _handleProceed() {
    setState(() => _bvnApiError = false);

    // Run format validation first via form
    if (!_formKey.currentState!.validate()) return;

    final modeName = _mode == _VerifyMode.bvn ? 'BVN' : 'NIN';

    // Check DOB is selected
    if (_dobController.text.trim().isEmpty) {
      setState(() {
        _bvnApiError = true;
        _bvnApiErrorMessage = 'Please select your date of birth';
      });
      _formKey.currentState!.validate();
      return;
    }

    // Mock-backend check via central validators
    final result = AppValidators.checkBvnNin(
      value: _numberController.text.trim(),
      mode: modeName,
      dateOfBirth: _dobController.text.trim(),
    );

    if (result != BvnNinResult.valid) {
      setState(() {
        _bvnApiError = true;
        _bvnApiErrorMessage = result.errorMessage(modeName);
      });
      _formKey.currentState!.validate(); // surfaces error on the field
      return;
    }

    // All good — show phone confirmation dialog
    _showConfirmPhoneDialog();
  }

  void _showConfirmPhoneDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ConfirmPhoneSheet(
        phoneNumber: widget.phoneNumber,
        onYes: () {
          Navigator.pop(context); // close sheet
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => VerifyBvnOtpScreen(
                phoneNumber: widget.phoneNumber,
                email: widget.email,
                bvnOrNin: _numberController.text.trim(),
                verifyMode: _mode == _VerifyMode.bvn ? 'BVN' : 'NIN',
                dateOfBirth: _dobController.text.trim(),
              ),
            ),
          );
        },
        onNo: () {
          Navigator.pop(context); // close sheet
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const UpdateBvnDetailsScreen(),
            ),
          );
        },
      ),
    );
  }

  // _triggerBvnError kept for future API integration
  @override
  Widget build(BuildContext context) {
    final stepNumber = _mode == _VerifyMode.bvn ? 3 : 4;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AuthHeader(
              title: 'Verify BVN / NIN',
              subtitle: "Welcome to Moore, let's get started!",
              currentStep: stepNumber,
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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Description
                        const MooreText(
                          'To sign up, enter your BVN or NIN for secure and faster transactions. Your data is safe with us and only used for verification.',
                          fontSize: 13,
                          color: AppColors.textDarkSecondary,
                          height: 1.55,
                        ),
                        const SizedBox(height: 24),

                        // BVN / NIN Toggle Cards
                        Row(
                          children: [
                            _ModeCard(
                              label: 'BVN',
                              subLabel: 'Bank Verification\nNumber',
                              isSelected: _mode == _VerifyMode.bvn,
                              onTap: () => setState(() {
                                _mode = _VerifyMode.bvn;
                                _numberController.clear();
                                _dobController.clear();
                                _bvnApiError = false;
                                _formKey.currentState?.reset();
                              }),
                            ),
                            const SizedBox(width: 12),
                            _ModeCard(
                              label: 'NIN',
                              subLabel: 'National Identification\nNumber',
                              isSelected: _mode == _VerifyMode.nin,
                              onTap: () => setState(() {
                                _mode = _VerifyMode.nin;
                                _numberController.clear();
                                _dobController.clear();
                                _bvnApiError = false;
                                _formKey.currentState?.reset();
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Helper tip
                        MooreText(
                          _mode == _VerifyMode.bvn
                              ? 'To get your 11 digits BVN dial *565*0# on your registered BVN line.'
                              : 'To get your NIN dial *346# on your registered NIN line.',
                          fontSize: 12,
                          color: AppColors.textDarkSecondary,
                          height: 1.5,
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
                          child: MooreText(
                            _mode == _VerifyMode.bvn
                                ? 'Test BVN: 12345678901 · DOB: 01/01/1990'
                                : 'Test NIN: 98765432101 · DOB: 01/01/1990',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Number field
                        _buildLabel('$_numberLabel *'),
                        const SizedBox(height: 8),
                        AppInputField(
                          controller: _numberController,
                          hint: 'eg. 12345678901',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          maxLength: _numberLength,
                          onChanged: (_) {
                            if (_bvnApiError) setState(() => _bvnApiError = false);
                          },
                          validator: (v) {
                            final formatError = AppValidators.bvnNinFormat(v, _numberLabel);
                            if (formatError != null) return formatError;
                            if (_bvnApiError) return _bvnApiErrorMessage;
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Date of birth
                        _buildLabel('Date of birth *'),
                        const SizedBox(height: 8),
                        AppInputField(
                          controller: _dobController,
                          hint: 'MM/DD/YYYY',
                          readOnly: true,
                          onTap: _pickDate,
                          suffixIcon: const Icon(
                            Icons.calendar_today_outlined,
                            size: 18,
                            color: AppColors.textDarkSecondary,
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Please select your date of birth';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),

                        MooreButton(
                          text: 'Proceed',
                          onPressed: _handleProceed,
                        ),
                        const SizedBox(height: 24),

                        Center(
                          child: TextButton(
                            onPressed: () =>
                                Navigator.of(context).popUntil((r) => r.isFirst),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => MooreText(
        text,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textDarkPrimary,
      );
}

// ═══════════════════════════════════════════════════════════
// CONFIRM PHONE BOTTOM SHEET
// ═══════════════════════════════════════════════════════════
class _ConfirmPhoneSheet extends StatelessWidget {
  final String phoneNumber;
  final VoidCallback onYes;
  final VoidCallback onNo;

  const _ConfirmPhoneSheet({
    required this.phoneNumber,
    required this.onYes,
    required this.onNo,
  });

  String _masked(String phone) {
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 6) return '*****$digits';
    return '*****${digits.substring(digits.length - 4)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
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

          // Info icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.info_outline_rounded,
              color: AppColors.primary,
              size: 32,
            ),
          ),
          const SizedBox(height: 20),

          const MooreText(
            'Confirm the phone number\nassociated with your BVN.',
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.textDarkPrimary,
            textAlign: TextAlign.center,
            height: 1.4,
          ),
          const SizedBox(height: 12),

          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 13,
                color: AppColors.textDarkSecondary,
                height: 1.5,
              ),
              children: [
                const TextSpan(text: 'Please confirm that you can still access '),
                TextSpan(
                  text: _masked(phoneNumber),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDarkPrimary,
                  ),
                ),
                const TextSpan(text: ", and we'll send you a verification code."),
              ],
            ),
          ),
          const SizedBox(height: 28),

          MooreButton(text: 'Yes', onPressed: onYes),
          const SizedBox(height: 12),
          MooreButton(
            text: 'No',
            isOutlined: true,
            textColor: AppColors.primary,
            borderColor: AppColors.primary,
            onPressed: onNo,
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// UPDATE BVN DETAILS SCREEN
// ═══════════════════════════════════════════════════════════
class UpdateBvnDetailsScreen extends StatelessWidget {
  const UpdateBvnDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const AuthHeader(
              title: 'Update BVN details',
              subtitle: "Welcome to Moore, let's get started!",
              showLogo: true,
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
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),

                      // Info icon
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.info_outline_rounded,
                          color: AppColors.primary,
                          size: 38,
                        ),
                      ),
                      const SizedBox(height: 24),

                      const MooreText(
                        'Update BVN details',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDarkPrimary,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),

                      const MooreText(
                        'Please visit any branch of the bank where you registered your BVN to update your phone number. The update process might take up to 72 hours or more, depending on the bank.',
                        fontSize: 14,
                        color: AppColors.textDarkSecondary,
                        textAlign: TextAlign.center,
                        height: 1.6,
                      ),
                      const Spacer(),

                      MooreButton(
                        text: 'Okay',
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(height: 24),
                    ],
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

// ═══════════════════════════════════════════════════════════
// BVN / NIN TOGGLE CARD
// ═══════════════════════════════════════════════════════════
class _ModeCard extends StatelessWidget {
  final String label;
  final String subLabel;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModeCard({
    required this.label,
    required this.subLabel,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.borderLight,
              width: isSelected ? 1.8 : 1.0,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    )
                  ]
                : [],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 18,
                height: 18,
                margin: const EdgeInsets.only(top: 2, right: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        isSelected ? AppColors.primary : AppColors.borderLight,
                    width: isSelected ? 5.0 : 1.5,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MooreText(
                      label,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDarkPrimary,
                    ),
                    const SizedBox(height: 4),
                    MooreText(
                      subLabel,
                      fontSize: 11,
                      color: AppColors.textDarkSecondary,
                      height: 1.4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
