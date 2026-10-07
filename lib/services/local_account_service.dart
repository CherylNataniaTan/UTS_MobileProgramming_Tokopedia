import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAccountService {
  static const String _key = 'registered_accounts';

  static Future<List<Map<String, dynamic>>> _loadAccounts() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    return (jsonDecode(raw) as List)
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  static Future<String?> register({
    required String name,
    required String email,
    required String username,
    required String password,
  }) async {
    final accounts = await _loadAccounts();

    final emailTaken = accounts.any(
      (a) => a['email'].toString().toLowerCase() == email.toLowerCase(),
    );
    if (emailTaken) return 'Email sudah terdaftar';

    final usernameTaken = accounts.any(
      (a) => a['username'].toString().toLowerCase() == username.toLowerCase(),
    );
    if (usernameTaken) return 'Username sudah dipakai';

    accounts.add({
      'name': name,
      'email': email,
      'username': username,
      'password': password,
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(accounts));
    return null;
  }


  static Future<Map<String, dynamic>?> login(
    String identifier,
    String password,
  ) async {
    final accounts = await _loadAccounts();
    final id = identifier.trim().toLowerCase();

    for (final a in accounts) {
      final matchId = a['email'].toString().toLowerCase() == id ||
          a['username'].toString().toLowerCase() == id;
      if (matchId && a['password'] == password) return a;
    }
    return null;
  }
}