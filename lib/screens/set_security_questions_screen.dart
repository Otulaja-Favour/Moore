// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:moove/components/auth_header.dart';
import 'package:moove/components/custom_button.dart';
import 'package:moove/components/custom_text.dart';
import 'package:moove/constants/colors.dart';
import 'package:moove/screens/dashboard_screen.dart';
import 'package:moove/services/storage_service.dart';

class SetSecurityQuestionsScreen extends StatefulWidget {
  final String phoneNumber;
  final String email;
  final String bvnOrNin;
  final String verifyMode;
  final String dateOfBirth;
  final String passcode;
  final String transactionPin;

  const SetSecurityQuestionsScreen({
    super.key,
    required this.phoneNumber,
    required this.email,
    required this.bvnOrNin,
    required this.verifyMode,
    required this.dateOfBirth,
    required this.passcode,
    required this.transactionPin,
  });

  @override
  State<SetSecurityQuestionsScreen> createState() =>
      _SetSecurityQuestionsScreenState();
}

class _SetSecurityQuestionsScreenState
    extends State<SetSecurityQuestionsScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  final List<String> _allQuestions = [
    'What is the name of your favorite childhood friend?',
    'What primary school did you attend?',
    'What is the name of your first pet?',
    'What is the name of your best friend?',
    'What street did you grow up on as a kid?',
    'In what city did you meet your spouse or partner?',
    'What was the make of your first car?',
    'What was your childhood nickname?',
  ];

  late List<String?> _selectedQuestions;
  late List<TextEditingController> _answerControllers;
  bool _agreedToTerms = false;

  @override
  void initState() {
    super.initState();
    _selectedQuestions = [null, null];
    _answerControllers = List.generate(2, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var c in _answerControllers) {
      c.dispose();
    }
    super.dispose();
  }

  List<String> _availableQuestions(int slotIndex) {
    final otherSlot = slotIndex == 0 ? 1 : 0;
    return _allQuestions
        .where((q) => q != _selectedQuestions[otherSlot])
        .toList();
  }

  Future<void> _handleProceed() async {
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Please agree to the Privacy Policy and Terms of Service'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    // Build and save the user to local storage
    final user = MooreUser(
      email: widget.email,
      phoneNumber: widget.phoneNumber,
      bvnOrNin: widget.bvnOrNin,
      verifyMode: widget.verifyMode,
      dateOfBirth: widget.dateOfBirth,
      passcode: widget.passcode,
      transactionPin: widget.transactionPin,
      securityQuestions: [
        {
          'question': _selectedQuestions[0]!,
          'answer': _answerControllers[0].text.trim(),
        },
        {
          'question': _selectedQuestions[1]!,
          'answer': _answerControllers[1].text.trim(),
        },
      ],
    );

    await StorageService.instance.saveUser(user);

    setState(() => _isSaving = false);

    if (!mounted) return;
    _showCongratulations();
  }

  void _showCongratulations() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      builder: (_) => _CongratulationsSheet(
        onGoToDashboard: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const DashboardScreen()),
            (route) => false,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const AuthHeader(
              title: 'Set Security Questions',
              subtitle: 'Secure your account',
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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MooreText(
                          'Select and answer 2 security questions.',
                          fontSize: 13,
                          color: AppColors.textDarkSecondary,
                        ),
                        const SizedBox(height: 24),
                        _buildQuestionSlot(0),
                        const SizedBox(height: 24),
                        _buildQuestionSlot(1),
                        const SizedBox(height: 28),

                        // Terms checkbox
                        GestureDetector(
                          onTap: () => setState(
                              () => _agreedToTerms = !_agreedToTerms),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: _agreedToTerms,
                                activeColor: AppColors.primary,
                                onChanged: (v) => setState(
                                    () => _agreedToTerms = v ?? false),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Wrap(
                                  children: [
                                    const MooreText(
                                      'I agree to Moore ',
                                      fontSize: 13,
                                      color: AppColors.textDarkSecondary,
                                    ),
                                    const MooreText(
                                      'Privacy Policy',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textBlue,
                                    ),
                                    const MooreText(
                                      ' and ',
                                      fontSize: 13,
                                      color: AppColors.textDarkSecondary,
                                    ),
                                    const MooreText(
                                      'Terms of Service',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textBlue,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        _isSaving
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: AppColors.primary))
                            : MooreButton(
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

  Widget _buildQuestionSlot(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MooreText(
          'Security question ${index + 1} *',
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textDarkPrimary,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedQuestions[index],
          isExpanded: true,
          hint: const Text(
            'Select a question',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                color: AppColors.textDarkPlaceholder),
          ),
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 13,
            color: AppColors.textDarkPrimary,
          ),
          decoration: _inputDecoration(),
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
          items: _availableQuestions(index)
              .map((q) => DropdownMenuItem(value: q, child: Text(q)))
              .toList(),
          onChanged: (val) => setState(() {
            _selectedQuestions[index] = val;
            _answerControllers[index].clear();
          }),
          validator: (v) => v == null ? 'Please select a question' : null,
        ),
        const SizedBox(height: 12),
        MooreText(
          'Your answer *',
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textDarkPrimary,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _answerControllers[index],
          style: const TextStyle(fontFamily: 'Montserrat', fontSize: 14),
          decoration: _inputDecoration().copyWith(hintText: 'Your answer'),
          validator: (v) {
            if (v == null || v.trim().isEmpty) {
              return 'Please enter your answer';
            }
            if (v.trim().length < 2) {
              return 'Answer is too short';
            }
            return null;
          },
        ),
      ],
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      hintStyle: const TextStyle(
          fontFamily: 'Montserrat',
          color: AppColors.textDarkPlaceholder,
          fontSize: 14),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.borderLight)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.borderLight)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: AppColors.primary, width: 1.5)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.2)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.5)),
      errorStyle:
          const TextStyle(fontFamily: 'Montserrat', fontSize: 12),
    );
  }
}

// ─────────────────────────────────────────────
// Congratulations bottom sheet
// ─────────────────────────────────────────────
class _CongratulationsSheet extends StatelessWidget {
  final VoidCallback onGoToDashboard;
  const _CongratulationsSheet({required this.onGoToDashboard});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Spacer(),
          const Text('🎉', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 20),
          const MooreText(
            'Congratulations',
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.textDarkPrimary,
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: MooreText(
              "Your account has been created successfully. Welcome to Moore!",
              fontSize: 13,
              color: AppColors.textDarkSecondary,
              textAlign: TextAlign.center,
              height: 1.55,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: MooreButton(
              text: 'Go to Dashboard',
              onPressed: () {
                Navigator.pop(context);
                onGoToDashboard();
              },
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
