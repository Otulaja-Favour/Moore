// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:moove/components/custom_text.dart';
import 'package:moove/constants/assets.dart';
import 'package:moove/constants/colors.dart';
import 'package:moove/screens/dashboard_screen.dart';
import 'package:moove/screens/login_flow_screens.dart';
import 'package:moove/screens/replace_device_screen.dart';
import 'package:moove/services/storage_service.dart';

/// Login passcode entry screen — validates against stored passcode.
class PasscodeScreen extends StatefulWidget {
  final String phoneNumber;
  const PasscodeScreen({super.key, required this.phoneNumber});

  @override
  State<PasscodeScreen> createState() => _PasscodeScreenState();
}

class _PasscodeScreenState extends State<PasscodeScreen> {
  String _passcode = '';
  bool _hasError = false;
  static const int _length = 5;

  void _onKey(String v) {
    if (_passcode.length < _length) {
      setState(() {
        _passcode += v;
        _hasError = false;
      });
      if (_passcode.length == _length) {
        Future.delayed(const Duration(milliseconds: 150), _validate);
      }
    }
  }

  void _onBack() {
    if (_passcode.isNotEmpty) {
      setState(() {
        _passcode = _passcode.substring(0, _passcode.length - 1);
        _hasError = false;
      });
    }
  }

  void _onReset() => setState(() {
        _passcode = '';
        _hasError = false;
      });

  Future<void> _validate() async {
    final ok = await StorageService.instance.validatePasscode(_passcode);
    if (!mounted) return;
    if (ok) {
      await StorageService.instance.setLoggedIn(true);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ReplaceDeviceScreen(
            phoneNumber: widget.phoneNumber,
          ),
        ),
      );
    } else {
      setState(() {
        _hasError = true;
        _passcode = '';
      });
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.gradientStart, AppColors.gradientEnd],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 22),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const MooreText(
                      'Enter Passcode',
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    Image.asset(AppAssets.logo,
                        height: 26, fit: BoxFit.contain),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // Icon
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.06),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.10), width: 1.5),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.12),
                    ),
                    child: const Icon(Icons.grid_view_rounded,
                        color: Colors.white, size: 30),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_length, (i) {
                  final filled = i < _passcode.length;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _hasError
                          ? Colors.red[300]
                          : filled
                              ? Colors.white
                              : Colors.white.withOpacity(0.28),
                    ),
                  );
                }),
              ),

              if (_hasError) ...[
                const SizedBox(height: 10),
                MooreText(
                  'Incorrect passcode. Try again.',
                  fontSize: 13,
                  color: Colors.red[300]!,
                  fontWeight: FontWeight.w500,
                ),
              ],

              const Spacer(flex: 3),

              // Keypad
              _buildKeypad(),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeypad() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          _keyRow(['1', '2', '3']),
          const SizedBox(height: 14),
          _keyRow(['4', '5', '6']),
          const SizedBox(height: 14),
          _keyRow(['7', '8', '9']),
          const SizedBox(height: 14),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              const SizedBox(width: 14),
              Expanded(child: _key('0')),
              const SizedBox(width: 14),
              Expanded(
                child: _tapKey(
                  child: const Icon(Icons.backspace_outlined,
                      color: Colors.white, size: 22),
                  onTap: _onBack,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _onReset,
            child: const MooreText(
              'Reset',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _keyRow(List<String> keys) {
    return Row(
      children: keys.asMap().entries.map((e) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: e.key == 0 ? 0 : 14),
            child: _key(e.value),
          ),
        );
      }).toList(),
    );
  }

  Widget _key(String digit) => _tapKey(
        onTap: () => _onKey(digit),
        child: MooreText(
          digit,
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      );

  Widget _tapKey({required Widget child, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 62,
        decoration: BoxDecoration(
          color: const Color(0xFF3D6BF5),
          borderRadius: BorderRadius.circular(14),
          border:
              Border.all(color: Colors.white.withOpacity(0.15), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
