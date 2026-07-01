// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moove/constants/colors.dart';

/// Shared input field used across all auth screens.
/// - Consistent border radius, colours and typography
/// - Error state shows red border + red ⓘ suffix icon (matches Figma)
/// - Supports prefix widget (e.g. country code), suffix icon, obscure text
class AppInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String? label;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? prefixWidget;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  const AppInputField({
    super.key,
    required this.controller,
    required this.hint,
    this.label,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.prefixWidget,
    this.suffixIcon,
    this.inputFormatters,
    this.maxLength,
  });

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  bool _hasError = false;

  static const double _radius = 12.0;

  InputDecoration _decoration(bool hasError) {
    return InputDecoration(
      hintText: widget.hint,
      hintStyle: const TextStyle(
        fontFamily: 'Montserrat',
        color: AppColors.textDarkPlaceholder,
        fontSize: 14,
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      // Prefix (e.g. +234 country code)
      prefixIcon: widget.prefixWidget,
      // Suffix: error icon when invalid, custom icon otherwise
      suffixIcon: hasError
          ? Container(
              margin: const EdgeInsets.only(right: 12),
              child: const Icon(
                Icons.error_outline_rounded,
                color: Colors.red,
                size: 22,
              ),
            )
          : widget.suffixIcon,
      // Borders
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: const BorderSide(color: AppColors.borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: BorderSide(
          color: hasError ? Colors.red : AppColors.borderLight,
          width: hasError ? 1.4 : 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: BorderSide(
          color: hasError ? Colors.red : AppColors.primary,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: const BorderSide(color: Colors.red, width: 1.4),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      // Error text shown below field
      errorStyle: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 12,
        color: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      inputFormatters: [
        if (widget.maxLength != null)
          LengthLimitingTextInputFormatter(widget.maxLength),
        if (widget.inputFormatters != null) ...widget.inputFormatters!,
      ],
      style: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 15,
        color: AppColors.textDarkPrimary,
      ),
      decoration: _decoration(_hasError),
      onChanged: (v) {
        if (_hasError) setState(() => _hasError = false);
        widget.onChanged?.call(v);
      },
      validator: (v) {
        final error = widget.validator?.call(v);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) setState(() => _hasError = error != null);
        });
        return error;
      },
    );
  }
}

/// Convenience widget that wraps a label + AppInputField together.
class LabeledInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? prefixWidget;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  const LabeledInputField({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.prefixWidget,
    this.suffixIcon,
    this.inputFormatters,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textDarkPrimary,
          ),
        ),
        const SizedBox(height: 8),
        AppInputField(
          controller: controller,
          hint: hint,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          obscureText: obscureText,
          readOnly: readOnly,
          onTap: onTap,
          prefixWidget: prefixWidget,
          suffixIcon: suffixIcon,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
        ),
      ],
    );
  }
}

/// Country code prefix widget used on phone number fields.
class PhonePrefixWidget extends StatelessWidget {
  const PhonePrefixWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(
            '+234',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey[600]),
        ],
      ),
    );
  }
}
