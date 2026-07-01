// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:moove/components/auth_header.dart';
import 'package:moove/components/custom_button.dart';
import 'package:moove/components/custom_text.dart';
import 'package:moove/constants/colors.dart';

class SecurityQuestionScreen extends StatefulWidget {
  const SecurityQuestionScreen({super.key});

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
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: const _OtpBottomSheetFlow(),
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
  const _OtpBottomSheetFlow();

  @override
  State<_OtpBottomSheetFlow> createState() => _OtpBottomSheetFlowState();
}

class _OtpBottomSheetFlowState extends State<_OtpBottomSheetFlow> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  bool _isCodeInvalid = false;
  bool _showFailureContent = false;

  @override
  void initState() {
    super.initState();
    // Pre-populate with "5" to match the Figma mockup initially
    for (int i = 0; i < 4; i++) {
      _controllers[i].text = '5';
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleProceed() {
    if (!_isCodeInvalid) {
      // First click: trigger invalid code state (as shown in Figma)
      setState(() {
        _isCodeInvalid = true;
      });
    } else {
      // Second click: show binding failure content inside the sheet
      setState(() {
        _showFailureContent = true;
      });
    }
  }

  void _handleTryAgain() {
    setState(() {
      _showFailureContent = false;
      _isCodeInvalid = false;
      for (var controller in _controllers) {
        controller.clear();
      }
    });
    // Wait a brief frame for context layout transition, then focus first field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNodes[0].requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Drag Indicator Handle
        Container(
          width: 40,
          height: 4,
          margin: const EdgeInsets.only(top: 12, bottom: 8),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _showFailureContent 
                ? _buildFailureContent(context) 
                : _buildOtpContent(context),
          ),
        ),
      ],
    );
  }

  Widget _buildOtpContent(BuildContext context) {
    final themeBorderColor = _isCodeInvalid ? Colors.red[300]! : AppColors.borderLight;
    final themeTextColor = _isCodeInvalid ? Colors.red : AppColors.textDarkPrimary;

    return SingleChildScrollView(
      key: const ValueKey('OtpContent'),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          // Lock Icon Graphic
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.06),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lock_person_outlined,
              color: AppColors.primary,
              size: 40,
            ),
          ),
          const SizedBox(height: 20),
          // Title
          const MooreText(
            'Verify OTP',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textDarkPrimary,
          ),
          const SizedBox(height: 8),
          // Subtitle
          const MooreText(
            'We sent a 4-digit code to +234*****018',
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.textDarkSecondary,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          // OTP Input Fields
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) {
              return SizedBox(
                width: 56,
                height: 56,
                child: TextFormField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: themeTextColor,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: themeBorderColor, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: _isCodeInvalid ? Colors.red : AppColors.primary,
                        width: 2.0,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty && index < 3) {
                      _focusNodes[index + 1].requestFocus();
                    } else if (value.isEmpty && index > 0) {
                      _focusNodes[index - 1].requestFocus();
                    }
                  },
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          // Error & Resend Options
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Opacity(
                opacity: _isCodeInvalid ? 1.0 : 0.0,
                child: const MooreText(
                  'invalid code',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isCodeInvalid = false;
                    for (var controller in _controllers) {
                      controller.clear();
                    }
                    _focusNodes[0].requestFocus();
                  });
                },
                child: const MooreText(
                  'Resend code',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 36),
          // Proceed Button
          MooreButton(
            text: 'Proceed',
            onPressed: _handleProceed,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildFailureContent(BuildContext context) {
    return SingleChildScrollView(
      key: const ValueKey('FailureContent'),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          // Sad Face Emoji Icon Container
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Color(0xFFFEF2F2),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: MooreText(
                '😞',
                fontSize: 44,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Error Title
          const MooreText(
            'Device Binding\nFailed',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.redAccent,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          // Explanatory Text
          MooreText(
            'We were unable to securely bind this device to your Moore account. Please check your network or try again.',
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.grey[600],
            textAlign: TextAlign.center,
            height: 1.5,
          ),
          const SizedBox(height: 36),
          // Try Again Button
          MooreButton(
            text: 'Try Again',
            onPressed: _handleTryAgain,
          ),
          const SizedBox(height: 16),
          // Close Button
          MooreButton(
            text: 'Close',
            isOutlined: true,
            textColor: AppColors.primary,
            borderColor: AppColors.primary,
            onPressed: () {
              Navigator.pop(context); // Close bottom sheet
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
