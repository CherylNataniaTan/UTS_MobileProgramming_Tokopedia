import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import 'local_account_service.dart';

class ProfileStorageService {
  Future<String> _prefix() async {
    final current = await LocalAccountService.getCurrent();
    final id = (current?['username'] ?? 'guest').toString().toLowerCase();
    return 'profile_$id';
  }

  // Simpan data
  Future<void> saveUserProfile(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final p = await _prefix();

    await prefs.setString('${p}_name', user.name);
    await prefs.setString('${p}_username', user.username);

    if (user.profileImagePath != null) {
      await prefs.setString('${p}_image_path', user.profileImagePath!);
    }
  }

  Future<UserModel> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final p = await _prefix();
    final current = await LocalAccountService.getCurrent();

    final defaultName = (current?['name'] ?? 'Pengguna').toString();
    final defaultUsername =
        current != null ? '@${current['username']}' : '@pengguna';

    return UserModel(
      name: prefs.getString('${p}_name') ?? defaultName,
      username: prefs.getString('${p}_username') ?? defaultUsername,
      profileImagePath: prefs.getString('${p}_image_path'),
    );
  }
}