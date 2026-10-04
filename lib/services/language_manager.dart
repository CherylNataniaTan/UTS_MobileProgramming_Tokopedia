import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageManager {
  static final ValueNotifier<String> appLanguage = ValueNotifier<String>('id');

  //ngeload bahasa yang tersimpan di SharedPreferences saat aplikasi dijalankan
  static Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    appLanguage.value = prefs.getString('app_lang') ?? 'id';
  }

  //buat fungsi untuk menyimpan bahasa yang dipilih
  static Future<void> setLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_lang', lang);
    appLanguage.value = lang;
  }

  // Kamus Terjemahan Global Aplikasi
  static final Map<String, Map<String, String>> _localizedValues = {
    'id': {
      // Menu/Tab
      'home': 'Beranda',
      'orders': 'Pesanan',
      'profile': 'Profil',
      'settings': 'Pengaturan Akun',
      // Profile Screen
      'my_profile': 'Profil Saya',
      'edit_profile': 'Ubah Profil',
      'voucher': 'Voucher Saya',
      'address': 'Alamat Pengiriman',
      'help': 'Pusat Bantuan',
      'logout': 'Keluar',
      // Settings Screen
      'notifications': 'Notifikasi',
      'notif_sub': 'Nyalakan atau matikan notifikasi',
      'security': 'Keamanan & Privasi',
      'security_sub': 'Ubah kata sandi akun Anda',
      'language': 'Bahasa',
      'lang_name': 'Indonesia',
    },
    'en': {
      // Menu/Tab
      'home': 'Home',
      'orders': 'Orders',
      'profile': 'Profile',
      'settings': 'Account Settings',
      // Profile Screen
      'my_profile': 'My Profile',
      'edit_profile': 'Edit Profile',
      'voucher': 'My Voucher',
      'address': 'Shipping Address',
      'help': 'Help Center',
      'logout': 'Logout',
      // Settings Screen
      'notifications': 'Notifications',
      'notif_sub': 'Enable or disable app notifications',
      'security': 'Security & Privacy',
      'security_sub': 'Change your account password',
      'language': 'Language',
      'lang_name': 'English',
    },
  };

  //bantu ambil teks terjemahan sesuai bahasa yang dipilih
  static String getText(String key) {
    return _localizedValues[appLanguage.value]?[key] ?? key;
  }
}