import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../models/order_model.dart';
// import '../models/voucher_model.dart';
import '../services/profile_storage_service.dart';
import '../services/language_manager.dart';
import '../widgets/profile_header_widget.dart';
import '../widgets/order_status_widget.dart';
import '../widgets/voucher_widget.dart';
import '../widgets/menu_list_widget.dart';
import '../data/voucher_data.dart';

import 'edit_profile_screen.dart';
import 'orders_screen.dart';
import 'voucher_screen.dart';
import 'Alamat_Pengiriman_Screen.dart';
import 'Settings_Screen.dart';
import 'help_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserModel user;
  final ProfileStorageService _storageService = ProfileStorageService();

  @override
  void initState() {
    super.initState();
    user = UserModel(name: 'Dimas', username: '@dimas', profileImage: '');
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final savedUser = await _storageService.getUserProfile();
    if (savedUser != null) {
      setState(() {
        user = savedUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final orders = dummyOrders;

    final vouchers = userVouchers;

    final processingCount = orders.where((o) => o.status == 'Diproses').length;
    final shippingCount = orders.where((o) => o.status == 'Dikirim').length;
    final completedCount = orders.where((o) => o.status == 'Selesai').length;

    //buat ubah bahasa sesuai yang dipilih
    return ValueListenableBuilder<String>(
      valueListenable: LanguageManager.appLanguage,
      builder: (context, currentLang, child) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: Text(
              LanguageManager.getText('my_profile'), // Teks Dinamis
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 112, 13, 27),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Header Profile
                ProfileHeaderWidget(
                  name: user.name,
                  username: user.username,
                  imageUrl: user.profileImagePath ?? user.profileImage,
                  onEditProfile: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditProfileScreen(currentUser: user),
                      ),
                    );

                    if (result == true) {
                      _loadUserData();
                    }
                  },
                ),
                const SizedBox(height: 16),

                // Status Pesanan
                OrderStatusWidget(
                  processingCount: processingCount,
                  shippingCount: shippingCount,
                  completedCount: completedCount,
                  onProcessingTap: () =>
                      _navigateToOrders(context, 'Diproses', orders),
                  onShippingTap: () =>
                      _navigateToOrders(context, 'Dikirim', orders),
                  onCompletedTap: () =>
                      _navigateToOrders(context, 'Selesai', orders),
                ),
                const SizedBox(height: 16),

                // Voucher
                VoucherWidget(
                  voucherCount: vouchers.length,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VoucherScreen(vouchers: vouchers),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Menu List
                MenuListWidget(
                  onAddressTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AlamatPengirimanScreen(),
                      ),
                    );
                  },
                  onSettingsTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                  onHelpTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HelpScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Log out
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Color.from(
                        alpha: 1,
                        red: 0.439,
                        green: 0.051,
                        blue: 0.106,
                      ),
                    ),
                    title: Text(
                      LanguageManager.getText('logout'),
                      style: const TextStyle(
                        color: Color.from(
                          alpha: 1,
                          red: 0.439,
                          green: 0.051,
                          blue: 0.106,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Color.from(
                        alpha: 1,
                        red: 0.439,
                        green: 0.051,
                        blue: 0.106,
                      ),
                    ),
                    onTap: () => _showLogoutDialog(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToOrders(
    BuildContext context,
    String statusFilter,
    List<OrderModel> orders,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            OrdersScreen(initialStatusFilter: statusFilter, orders: orders),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: Text(
            LanguageManager.appLanguage.value == 'en'
                ? 'Confirm Logout'
                : 'Konfirmasi Log Out',
          ),
          content: Text(
            LanguageManager.appLanguage.value == 'en'
                ? 'Are you sure you want to log out?'
                : 'Apakah Anda yakin ingin keluar dari akun ini?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                LanguageManager.appLanguage.value == 'en' ? 'Cancel' : 'Batal',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 112, 13, 27),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: Text(
                LanguageManager.getText('logout'),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
