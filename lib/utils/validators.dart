/// Central validation utility — all form field validators live here.
/// Import this wherever you need validation.
///
/// Mock credentials for BVN/NIN testing (since users can't create real ones):
///   BVN : 12345678901  (dial *565*0# in real life)
///   NIN : 98765432101  (dial *346# in real life)
///   DOB : 01/01/1990
library;

class AppValidators {
  AppValidators._();

  // ── Mock credentials ─────────────────────────────────────────
  static const String mockBvn = '12345678901';
  static const String mockNin = '98765432101';
  static const String mockDob = '01/01/1990'; // MM/DD/YYYY

  // ══════════════════════════════════════════════════════════════
  // EMAIL
  // ══════════════════════════════════════════════════════════════
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }
    final trimmed = value.trim();
    if (!RegExp(r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$')
        .hasMatch(trimmed)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // ══════════════════════════════════════════════════════════════
  // NIGERIAN PHONE NUMBER
  // ══════════════════════════════════════════════════════════════
  /// Accepts 10-digit local numbers (7XXXXXXXXX) or
  /// full numbers starting with 0 (08012345678) or +234.
  /// The +234 prefix is handled at the UI level so we only validate
  /// the digits the user types into the field.
  static String? phoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }
    final digits = value.replaceAll(RegExp(r'\D'), '');

    if (digits.length < 10 || digits.length > 11) {
      return 'Enter a valid Nigerian phone number (10 digits)';
    }

    // Must start with a valid Nigerian network prefix
    // Local: 070, 080, 081, 090, 091 (remove leading 0 → 10 digits)
    //        or just the 10-digit form starting with 7, 8, 9
    final normalized =
        digits.length == 11 && digits.startsWith('0') ? digits.substring(1) : digits;

    if (!RegExp(r'^[789]\d{9}$').hasMatch(normalized)) {
      return 'Enter a valid Nigerian phone number';
    }
    return null;
  }

  // ══════════════════════════════════════════════════════════════
  // BVN / NIN
  // ══════════════════════════════════════════════════════════════

  /// Returns null if format is valid (11 digits), otherwise an error string.
  static String? bvnNinFormat(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your $label';
    }
    if (!RegExp(r'^\d{11}$').hasMatch(value.trim())) {
      return '$label must be exactly 11 digits';
    }
    return null;
  }

  /// Full mock-backend BVN/NIN check.
  /// Returns a [BvnNinResult] — call this AFTER format validation passes.
  static BvnNinResult checkBvnNin({
    required String value,
    required String mode, // 'BVN' or 'NIN'
    required String dateOfBirth, // MM/DD/YYYY
  }) {
    final clean = value.trim();
    final dob = dateOfBirth.trim();

    // Format guard (should already be caught by bvnNinFormat but belt-and-braces)
    if (!RegExp(r'^\d{11}$').hasMatch(clean)) {
      return BvnNinResult.invalidFormat;
    }

    final expected = mode == 'BVN' ? mockBvn : mockNin;

    if (clean != expected) {
      return BvnNinResult.notFound;
    }

    if (dob.isEmpty) return BvnNinResult.dobMissing;
    if (dob != mockDob) return BvnNinResult.dobMismatch;

    return BvnNinResult.valid;
  }

  // ══════════════════════════════════════════════════════════════
  // DATE OF BIRTH
  // ══════════════════════════════════════════════════════════════
  static String? dateOfBirth(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please select your date of birth';
    }
    // Basic MM/DD/YYYY check
    if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value.trim())) {
      return 'Invalid date format';
    }
    return null;
  }

  // ══════════════════════════════════════════════════════════════
  // OTP
  // ══════════════════════════════════════════════════════════════
  static String? otp(String value, {int length = 4}) {
    if (value.length < length) {
      return 'Please enter the $length-digit code';
    }
    return null;
  }

  // ══════════════════════════════════════════════════════════════
  // SECURITY ANSWER
  // ══════════════════════════════════════════════════════════════
  static String? securityAnswer(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your answer';
    }
    if (value.trim().length < 2) {
      return 'Answer is too short';
    }
    return null;
  }
}

// ── Result type for BVN/NIN mock check ──────────────────────
enum BvnNinResult {
  valid,
  invalidFormat,
  notFound,
  dobMissing,
  dobMismatch;

  String errorMessage(String mode) {
    switch (this) {
      case BvnNinResult.notFound:
      case BvnNinResult.invalidFormat:
        return "Apologies, we can't validate your $mode at this time";
      case BvnNinResult.dobMissing:
        return 'Please select your date of birth';
      case BvnNinResult.dobMismatch:
        return 'Date of birth does not match your $mode records';
      case BvnNinResult.valid:
        return '';
    }
  }
}
