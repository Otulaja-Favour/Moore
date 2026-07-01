// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:moove/components/app_input_field.dart';
import 'package:moove/components/auth_header.dart';
import 'package:moove/components/custom_button.dart';
import 'package:moove/components/custom_text.dart';
import 'package:moove/constants/colors.dart';
import 'package:moove/screens/login_screen.dart';
import 'package:moove/screens/verify_phone_otp_screen.dart';
import 'package:moove/utils/validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _showTermsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
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
            const SizedBox(height: 16),
            const MooreText('Terms & Conditions',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textDarkPrimary),
            const SizedBox(height: 8),
            const Divider(color: AppColors.borderLight),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    MooreText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam pulvinar libero id orci blandit, ut mattis nec lacus vel purus ultricies interdum.',
                      fontSize: 14,
                      color: AppColors.textDarkSecondary,
                      height: 1.6,
                    ),
                    SizedBox(height: 16),
                    MooreText('1. Agreement to Terms',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDarkPrimary),
                    SizedBox(height: 8),
                    MooreText(
                      'By accessing our services, you agree to be bound by these terms.',
                      fontSize: 14,
                      color: AppColors.textDarkSecondary,
                      height: 1.5,
                    ),
                    SizedBox(height: 16),
                    MooreText('2. User Obligations',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDarkPrimary),
                    SizedBox(height: 8),
                    MooreText(
                      'You are responsible for keeping your credentials safe and maintaining accurate, updated information on your account profile.',
                      fontSize: 14,
                      color: AppColors.textDarkSecondary,
                      height: 1.5,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: MooreButton(
                  text: 'Accept & Close',
                  onPressed: () => Navigator.pop(context)),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSignUpSubmit() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => VerifyPhoneOtpScreen(
          phoneNumber: _phoneController.text.trim(),
          email: _emailController.text.trim(),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.gradientStart,
              AppColors.gradientEnd,
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const AuthHeader(
                title: 'Sign Up',
                subtitle: "Welcome to Moore, let's get started!",
                currentStep: 1,
                totalSteps: 5,
                showBackButton: true,
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MooreText('Create your account',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textDarkSecondary),
                          const SizedBox(height: 24),

                          // Email
                          LabeledInputField(
                            label: 'Email Address',
                            controller: _emailController,
                            hint: 'Enter Email Address',
                            keyboardType: TextInputType.emailAddress,
                            validator: AppValidators.email,
                          ),
                          const SizedBox(height: 20),

                          // Phone
                          LabeledInputField(
                            label: 'Phone Number',
                            controller: _phoneController,
                            hint: 'eg. 7032536254',
                            keyboardType: TextInputType.phone,
                            prefixWidget: const PhonePrefixWidget(),
                            validator: AppValidators.phoneNumber,
                          ),
                          const SizedBox(height: 24),

                          // Terms
                          Wrap(
                            children: [
                              const MooreText("By proceeding you agree to Moore's ",
                                  fontSize: 12, color: AppColors.textDarkSecondary),
                              GestureDetector(
                                onTap: _showTermsBottomSheet,
                                child: const MooreText('Terms of Service',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textBlue),
                              ),
                              const MooreText(' and ',
                                  fontSize: 12, color: AppColors.textDarkSecondary),
                              GestureDetector(
                                onTap: _showTermsBottomSheet,
                                child: const MooreText('Privacy Policy',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textBlue),
                              ),
                            ],
                          ),
                          const SizedBox(height: 36),

                          MooreButton(
                              text: 'Proceed', onPressed: _handleSignUpSubmit),
                          const SizedBox(height: 24),

                          Center(
                            child: TextButton(
                              onPressed: () => Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (_) => const LoginScreen())),
                              child: const MooreText('I already have an account',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textBlue),
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
      ),
    );
  }
}
