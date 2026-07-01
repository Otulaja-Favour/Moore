// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:moove/components/auth_header.dart';
import 'package:moove/components/custom_button.dart';
import 'package:moove/components/custom_text.dart';
import 'package:moove/constants/colors.dart';
import 'package:moove/screens/security_question_screen.dart';

class ReplaceDeviceScreen extends StatefulWidget {
  final String phoneNumber;
  const ReplaceDeviceScreen({super.key, required this.phoneNumber});

  @override
  State<ReplaceDeviceScreen> createState() => _ReplaceDeviceScreenState();
}

class _ReplaceDeviceScreenState extends State<ReplaceDeviceScreen> {
  int _selectedDeviceIndex = 0;

  final List<Map<String, String>> _devices = [
    {
      'name': 'iphone 14 Pro Max',
      'status': 'Existing device',
    },
    {
      'name': 'Samsung Galaxy Note 20',
      'status': 'Existing device',
    },
  ];

  void _handleReplaceDevice() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SecurityQuestionScreen(
          phoneNumber: widget.phoneNumber,
        ),
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
            // Header
            const AuthHeader(
              title: 'Welcome Back, Tomike!',
              subtitle: 'Replace an existing device',
              showLogo: true,
            ),
            const SizedBox(height: 12),
            // Form & Options Body
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
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      // List of devices
                      Expanded(
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _devices.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final device = _devices[index];
                            final isSelected = _selectedDeviceIndex == index;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedDeviceIndex = index;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected ? AppColors.primary : AppColors.borderLight,
                                    width: isSelected ? 1.5 : 1.0,
                                  ),
                                  boxShadow: [
                                    if (isSelected)
                                      BoxShadow(
                                        color: AppColors.primary.withOpacity(0.05),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    // Phone Icon
                                    Container(
                                      width: 40,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.phone_android,
                                        color: isSelected ? AppColors.primary : Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    // Device Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          MooreText(
                                            device['name']!,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.textDarkPrimary,
                                          ),
                                          const SizedBox(height: 4),
                                          MooreText(
                                            device['status']!,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textDarkSecondary,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Selection Indicator (Radio circle style)
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isSelected ? AppColors.primary : AppColors.borderLight,
                                          width: isSelected ? 6.0 : 1.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Explanatory Text
                      const MooreText(
                        'Simply follow the prompts to register this device and enjoy seamless access to your account.',
                        fontSize: 13,
                        height: 1.5,
                        color: AppColors.textDarkSecondary,
                      ),
                      const SizedBox(height: 32),
                      // Replace Device Button
                      MooreButton(
                        text: 'Replace Device',
                        onPressed: _handleReplaceDevice,
                      ),
                      const SizedBox(height: 16),
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
