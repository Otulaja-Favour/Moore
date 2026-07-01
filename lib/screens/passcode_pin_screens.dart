// ignore_for_file: deprecated_member_use
//
// Single file for all 4 passcode/PIN screens:
//   SetPasscodeScreen, ConfirmPasscodeScreen,
//   SetTransactionPinScreen, ConfirmTransactionPinScreen
//
// Shared: _PasscodeScaffold, _KeypadButton

import 'package:flutter/material.dart';
import 'package:moove/components/custom_text.dart';
import 'package:moove/constants/assets.dart';
import 'package:moove/constants/colors.dart';
import 'package:moove/screens/set_security_questions_screen.dart';

// ═══════════════════════════════════════════════════════════
// 1. SET PASSCODE
// ═══════════════════════════════════════════════════════════
class SetPasscodeScreen extends StatefulWidget {
  final String phoneNumber;
  final String email;
  final String bvnOrNin;
  final String verifyMode;
  final String dateOfBirth;

  const SetPasscodeScreen({
    super.key,
    required this.phoneNumber,
    required this.email,
    required this.bvnOrNin,
    required this.verifyMode,
    required this.dateOfBirth,
  });

  @override
  State<SetPasscodeScreen> createState() => _SetPasscodeScreenState();
}

class _SetPasscodeScreenState extends State<SetPasscodeScreen> {
  String _passcode = '';
  static const int _length = 5;

  void _onKey(String v) {
    if (_passcode.length < _length) {
      setState(() => _passcode += v);
      if (_passcode.length == _length) {
        Future.delayed(const Duration(milliseconds: 180), () {
          if (mounted) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ConfirmPasscodeScreen(
                phoneNumber: widget.phoneNumber,
                email: widget.email,
                bvnOrNin: widget.bvnOrNin,
                verifyMode: widget.verifyMode,
                dateOfBirth: widget.dateOfBirth,
                passcode: _passcode,
              ),
            ));
          }
        });
      }
    }
  }

  void _onBack() {
    if (_passcode.isNotEmpty) setState(() => _passcode = _passcode.substring(0, _passcode.length - 1));
  }

  @override
  Widget build(BuildContext context) => _PasscodeScaffold(
        title: 'Set Passcode',
        passcode: _passcode,
        length: _length,
        onKey: _onKey,
        onBack: _onBack,
        onReset: () => setState(() => _passcode = ''),
      );
}

// ═══════════════════════════════════════════════════════════
// 2. CONFIRM PASSCODE
// ═══════════════════════════════════════════════════════════
class ConfirmPasscodeScreen extends StatefulWidget {
  final String phoneNumber;
  final String email;
  final String bvnOrNin;
  final String verifyMode;
  final String dateOfBirth;
  final String passcode;

  const ConfirmPasscodeScreen({
    super.key,
    required this.phoneNumber,
    required this.email,
    required this.bvnOrNin,
    required this.verifyMode,
    required this.dateOfBirth,
    required this.passcode,
  });

  @override
  State<ConfirmPasscodeScreen> createState() => _ConfirmPasscodeScreenState();
}

class _ConfirmPasscodeScreenState extends State<ConfirmPasscodeScreen> {
  String _entry = '';
  bool _hasError = false;
  static const int _length = 5;

  void _onKey(String v) {
    if (_entry.length < _length) {
      setState(() {
        _entry += v;
        _hasError = false;
      });
      if (_entry.length == _length) {
        Future.delayed(const Duration(milliseconds: 150), _validate);
      }
    }
  }

  void _onBack() {
    if (_entry.isNotEmpty) {
      setState(() {
        _entry = _entry.substring(0, _entry.length - 1);
        _hasError = false;
      });
    }
  }

  void _validate() {
    if (_entry == widget.passcode) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => SetTransactionPinScreen(
          phoneNumber: widget.phoneNumber,
          email: widget.email,
          bvnOrNin: widget.bvnOrNin,
          verifyMode: widget.verifyMode,
          dateOfBirth: widget.dateOfBirth,
          passcode: widget.passcode,
        ),
      ));
    } else {
      setState(() {
        _hasError = true;
        _entry = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) => _PasscodeScaffold(
        title: 'Confirm Passcode',
        passcode: _entry,
        length: _length,
        onKey: _onKey,
        onBack: _onBack,
        onReset: () => setState(() {
          _entry = '';
          _hasError = false;
        }),
        hasError: _hasError,
        errorMessage: 'Passcodes do not match',
      );
}

// ═══════════════════════════════════════════════════════════
// 3. SET TRANSACTION PIN
// ═══════════════════════════════════════════════════════════
class SetTransactionPinScreen extends StatefulWidget {
  final String phoneNumber;
  final String email;
  final String bvnOrNin;
  final String verifyMode;
  final String dateOfBirth;
  final String passcode;

  const SetTransactionPinScreen({
    super.key,
    required this.phoneNumber,
    required this.email,
    required this.bvnOrNin,
    required this.verifyMode,
    required this.dateOfBirth,
    required this.passcode,
  });

  @override
  State<SetTransactionPinScreen> createState() => _SetTransactionPinScreenState();
}

class _SetTransactionPinScreenState extends State<SetTransactionPinScreen> {
  String _pin = '';
  static const int _length = 4;

  void _onKey(String v) {
    if (_pin.length < _length) {
      setState(() => _pin += v);
      if (_pin.length == _length) {
        Future.delayed(const Duration(milliseconds: 180), () {
          if (mounted) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ConfirmTransactionPinScreen(
                phoneNumber: widget.phoneNumber,
                email: widget.email,
                bvnOrNin: widget.bvnOrNin,
                verifyMode: widget.verifyMode,
                dateOfBirth: widget.dateOfBirth,
                passcode: widget.passcode,
                pin: _pin,
              ),
            ));
          }
        });
      }
    }
  }

  void _onBack() {
    if (_pin.isNotEmpty) setState(() => _pin = _pin.substring(0, _pin.length - 1));
  }

  @override
  Widget build(BuildContext context) => _PasscodeScaffold(
        title: 'Set Transaction PIN',
        passcode: _pin,
        length: _length,
        onKey: _onKey,
        onBack: _onBack,
        onReset: () => setState(() => _pin = ''),
      );
}

// ═══════════════════════════════════════════════════════════
// 4. CONFIRM TRANSACTION PIN
// ═══════════════════════════════════════════════════════════
class ConfirmTransactionPinScreen extends StatefulWidget {
  final String phoneNumber;
  final String email;
  final String bvnOrNin;
  final String verifyMode;
  final String dateOfBirth;
  final String passcode;
  final String pin;

  const ConfirmTransactionPinScreen({
    super.key,
    required this.phoneNumber,
    required this.email,
    required this.bvnOrNin,
    required this.verifyMode,
    required this.dateOfBirth,
    required this.passcode,
    required this.pin,
  });

  @override
  State<ConfirmTransactionPinScreen> createState() =>
      _ConfirmTransactionPinScreenState();
}

class _ConfirmTransactionPinScreenState extends State<ConfirmTransactionPinScreen> {
  String _entry = '';
  bool _hasError = false;
  static const int _length = 4;

  void _onKey(String v) {
    if (_entry.length < _length) {
      setState(() {
        _entry += v;
        _hasError = false;
      });
      if (_entry.length == _length) {
        Future.delayed(const Duration(milliseconds: 150), _validate);
      }
    }
  }

  void _onBack() {
    if (_entry.isNotEmpty) {
      setState(() {
        _entry = _entry.substring(0, _entry.length - 1);
        _hasError = false;
      });
    }
  }

  void _validate() {
    if (_entry == widget.pin) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => SetSecurityQuestionsScreen(
          phoneNumber: widget.phoneNumber,
          email: widget.email,
          bvnOrNin: widget.bvnOrNin,
          verifyMode: widget.verifyMode,
          dateOfBirth: widget.dateOfBirth,
          passcode: widget.passcode,
          transactionPin: widget.pin,
        ),
      ));
    } else {
      setState(() {
        _hasError = true;
        _entry = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) => _PasscodeScaffold(
        title: 'Confirm Transaction PIN',
        passcode: _entry,
        length: _length,
        onKey: _onKey,
        onBack: _onBack,
        onReset: () => setState(() {
          _entry = '';
          _hasError = false;
        }),
        hasError: _hasError,
        errorMessage: 'PINs do not match',
      );
}

// ═══════════════════════════════════════════════════════════
// SHARED SCAFFOLD
// ═══════════════════════════════════════════════════════════
class _PasscodeScaffold extends StatelessWidget {
  final String title;
  final String passcode;
  final int length;
  final void Function(String) onKey;
  final VoidCallback onBack;
  final VoidCallback onReset;
  final bool hasError;
  final String errorMessage;

  const _PasscodeScaffold({
    required this.title,
    required this.passcode,
    required this.length,
    required this.onKey,
    required this.onBack,
    required this.onReset,
    this.hasError = false,
    this.errorMessage = '',
  });

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
              // ── Header row ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
                      onPressed: () => Navigator.pop(context),
                    ),
                    MooreText(
                      title,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    Image.asset(AppAssets.logo, height: 26, fit: BoxFit.contain),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // ── Icon graphic ──
              _buildIconGraphic(),

              const SizedBox(height: 36),

              // ── Dot indicators ──
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(length, (i) {
                  final filled = i < passcode.length;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: hasError
                          ? Colors.red[300]
                          : filled
                              ? Colors.white
                              : Colors.white.withOpacity(0.28),
                    ),
                  );
                }),
              ),

              if (hasError) ...[
                const SizedBox(height: 10),
                MooreText(
                  errorMessage,
                  fontSize: 13,
                  color: Colors.red[300]!,
                  fontWeight: FontWeight.w500,
                ),
              ],

              const Spacer(flex: 3),

              // ── Keypad ──
              _buildKeypad(),

              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconGraphic() {
    // Figma shows a small illustration: a card/keypad icon inside a soft circle
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer glow ring
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.06),
            border: Border.all(color: Colors.white.withOpacity(0.10), width: 1.5),
          ),
        ),
        // Inner circle
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.12),
          ),
          child: const Icon(Icons.grid_view_rounded, color: Colors.white, size: 30),
        ),
      ],
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
          // Bottom row: empty | 0 | backspace
          Row(
            children: [
              const Expanded(child: SizedBox()),
              const SizedBox(width: 14),
              Expanded(child: _key('0')),
              const SizedBox(width: 14),
              Expanded(
                child: _actionKey(
                  child: const Icon(Icons.backspace_outlined, color: Colors.white, size: 22),
                  onTap: onBack,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Reset
          GestureDetector(
            onTap: onReset,
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

  Widget _key(String digit) {
    return _actionKey(
      child: MooreText(
        digit,
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      onTap: () => onKey(digit),
    );
  }

  Widget _actionKey({required Widget child, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 62,
        decoration: BoxDecoration(
          color: const Color(0xFF3D6BF5), // slightly lighter than gradient for contrast
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
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
