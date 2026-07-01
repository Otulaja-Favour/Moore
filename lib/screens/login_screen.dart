// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:moove/components/auth_header.dart';
import 'package:moove/components/custom_button.dart';
import 'package:moove/components/custom_text.dart';
import 'package:moove/components/support_button.dart';
import 'package:moove/constants/colors.dart';
import 'package:moove/screens/signup_screen.dart';
import 'package:moove/screens/passcode_screen.dart';
import 'package:moove/services/storage_service.dart';
import 'package:moove/utils/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final user = await StorageService.instance
        .validatePhone(_phoneController.text.trim());
    setState(() => _isLoading = false);

    if (!mounted) return;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No account found for this number. Please sign up first.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 4),
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PasscodeScreen(phoneNumber: user.phoneNumber),
      ),
    );
  }

  InputDecoration _fieldDecoration(String hint) => InputDecoration(
        hintText: hint,
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        errorStyle: const TextStyle(fontFamily: 'Montserrat', fontSize: 12),
      );

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
              Color(0xFF4A6CF7),
              AppColors.gradientStart,
              AppColors.gradientEnd,
            ],
            stops: [0.0, 0.45, 1.0],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
                children: [
                  const AuthHeader(
                    title: 'Welcome Back!',
                    subtitle: 'Log in to continue',
                    showLogo: true,
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
                        padding: const EdgeInsets.all(24.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              const MooreText(
                                'Phone Number',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textDarkPrimary,
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                style: const TextStyle(
                                    fontFamily: 'Montserrat', fontSize: 15),
                                decoration: _fieldDecoration('eg. 7032536254').copyWith(
                                  prefixIcon: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(color: AppColors.borderLight),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        MooreText(
                                          '+234',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[700],
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(Icons.keyboard_arrow_down,
                                            size: 16, color: Colors.grey[600]),
                                      ],
                                    ),
                                  ),
                                ),
                                validator: AppValidators.phoneNumber,
                              ),
                              const SizedBox(height: 36),
                              _isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                          color: AppColors.primary),
                                    )
                                  : MooreButton(
                                      text: 'Login',
                                      onPressed: _handleLogin,
                                    ),
                              const SizedBox(height: 48),
                              Center(
                                child: TextButton(
                                  onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => const SignUpScreen()),
                                  ),
                                  child: const MooreText(
                                    "I don't have an account",
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
              const Positioned(
                right: 24,
                bottom: 40,
                child: SupportButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
