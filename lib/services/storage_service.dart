import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class _Keys {
  static const String user = 'moore_user';
  static const String isLoggedIn = 'moore_is_logged_in';
}

/// All data collected during signup, persisted locally.
class MooreUser {
  final String email;
  final String phoneNumber;
  final String bvnOrNin;
  final String verifyMode; // 'BVN' or 'NIN'
  final String dateOfBirth;
  final String passcode;       // 5-digit
  final String transactionPin; // 4-digit
  final List<Map<String, String>> securityQuestions;

  const MooreUser({
    required this.email,
    required this.phoneNumber,
    required this.bvnOrNin,
    required this.verifyMode,
    required this.dateOfBirth,
    required this.passcode,
    required this.transactionPin,
    required this.securityQuestions,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'phoneNumber': phoneNumber,
        'bvnOrNin': bvnOrNin,
        'verifyMode': verifyMode,
        'dateOfBirth': dateOfBirth,
        'passcode': passcode,
        'transactionPin': transactionPin,
        'securityQuestions': securityQuestions,
      };

  factory MooreUser.fromJson(Map<String, dynamic> json) => MooreUser(
        email: json['email'] as String,
        phoneNumber: json['phoneNumber'] as String,
        bvnOrNin: json['bvnOrNin'] as String,
        verifyMode: json['verifyMode'] as String,
        dateOfBirth: json['dateOfBirth'] as String,
        passcode: json['passcode'] as String,
        transactionPin: json['transactionPin'] as String,
        securityQuestions: (json['securityQuestions'] as List)
            .map((e) => Map<String, String>.from(e as Map))
            .toList(),
      );
}

/// Singleton local-storage service.
class StorageService {
  StorageService._();
  static final StorageService instance = StorageService._();

  // ── Save ──────────────────────────────────────────────────
  Future<void> saveUser(MooreUser user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_Keys.user, jsonEncode(user.toJson()));
  }

  // ── Load ──────────────────────────────────────────────────
  Future<MooreUser?> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_Keys.user);
    if (raw == null) return null;
    try {
      return MooreUser.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  // ── Auth state ────────────────────────────────────────────
  Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_Keys.isLoggedIn, value);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_Keys.isLoggedIn) ?? false;
  }

  // ── Login: phone check ─────────────────────────────────────
  /// Returns the stored user ONLY if the normalised 10-digit local number
  /// matches exactly. Rejects if no account exists.
  Future<MooreUser?> validatePhone(String phone) async {
    final user = await loadUser();
    if (user == null) return null;

    // Normalise both to 10-digit local form (strip +234 or leading 0)
    String normalise(String p) {
      final d = p.replaceAll(RegExp(r'\D'), '');
      if (d.length == 13 && d.startsWith('234')) return d.substring(3);
      if (d.length == 11 && d.startsWith('0')) return d.substring(1);
      return d;
    }

    return normalise(user.phoneNumber) == normalise(phone) ? user : null;
  }

  // ── Login: passcode check ─────────────────────────────────
  Future<bool> validatePasscode(String passcode) async {
    final user = await loadUser();
    return user?.passcode == passcode;
  }

  // ── Clear everything ──────────────────────────────────────
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
