import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'keamanan_screen.dart';
import 'bahasa_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isNotifOn = true;
  String _currentLang = 'id';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Load status notifikasi & bahasa yang disimpan
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isNotifOn = prefs.getBool('is_notif_on') ?? true;
      _currentLang = prefs.getString('app_lang') ?? 'id';
    });
  }

  // Simpan  On/Off Notifikasi
  Future<void> _toggleNotif(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isNotifOn = value;
    });
    await prefs.setBool('is_notif_on', value);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value ? 'Notifikasi Dinyalakan' : 'Notifikasi Dimatikan'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryRed = Color(0xFFA01626);


    String title = _currentLang == 'en' ? 'Account Settings' : 'Pengaturan Akun';
    String notifTitle = _currentLang == 'en' ? 'Notifications' : 'Notifikasi';
    String notifSub = _currentLang == 'en'
        ? 'Enable or disable app notifications'
        : 'Nyalakan atau matikan notifikasi';
    String secTitle = _currentLang == 'en' ? 'Security & Privacy' : 'Keamanan & Privasi';
    String secSub = _currentLang == 'en'
        ? 'Change your account password'
        : 'Ubah kata sandi akun Anda';
    String langTitle = _currentLang == 'en' ? 'Language' : 'Bahasa';
    String langSub = _currentLang == 'en' ? 'English' : 'Indonesia';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          //notif
          SwitchListTile(
            activeColor: primaryRed,
            title: Text(notifTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(notifSub),
            secondary: const Icon(Icons.notifications_outlined, color:Color.from(alpha: 1, red: 0.439, green: 0.051, blue: 0.106)),
            value: _isNotifOn,
            onChanged: _toggleNotif,
          ),
          const Divider(),

          //keamanan n privasi
          ListTile(
            leading: const Icon(Icons.lock_outline, color: Color.from(alpha: 1, red: 0.439, green: 0.051, blue: 0.106)),
            title: Text(secTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(secSub),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const KeamananScreen()),
              );
            },
          ),
          const Divider(),

          //bahasa
          ListTile(
            leading: const Icon(Icons.language, color: Color.from(alpha: 1, red: 0.439, green: 0.051, blue: 0.106)),
            title: Text(langTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(langSub),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BahasaScreen()),
              );
              _loadSettings(); // Refresh setelah dari halaman Bahasa
            },
          ),
        ],
      ),
    );
  }
}