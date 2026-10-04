import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class ProfileStorageService {
  static const String _keyName = 'user_name';
  static const String _keyUsername = 'user_username';
  static const String _keyImagePath = 'user_image_path';

  // Simpan data
  Future<void> saveUserProfile(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, user.name);
    await prefs.setString(_keyUsername, user.username);

    if (user.profileImagePath != null) {
      await prefs.setString(_keyImagePath, user.profileImagePath!);
    }
  }

  // Ambil data
  Future<UserModel> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return UserModel(
      name: prefs.getString(_keyName) ?? 'Dimas',
      username: prefs.getString(_keyUsername) ?? '@dimas',
      profileImagePath: prefs.getString(_keyImagePath),
    );
  }
}
