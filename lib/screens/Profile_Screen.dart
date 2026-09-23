import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../models/order_model.dart';
import '../models/voucher_model.dart';
import '../widgets/profile_header_widget.dart';
import '../widgets/order_status_widget.dart';
import '../widgets/voucher_widget.dart';
import '../widgets/menu_list_widget.dart';

import 'edit_profile_screen.dart';
import 'orders_screen.dart';
import 'voucher_screen.dart';
import 'address_screen.dart';
import 'Settings_Screen.dart';
import 'help_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data Dummy User
    final user = UserModel(name: 'Dimas', username: '@dimas', profileImage: '');

    // Data Dummy Orders
    final orders = [
      OrderModel(
        id: 'ORD001',
        productName: 'Wireless Earphone',
        status: 'Diproses',
      ),
      OrderModel(id: 'ORD002', productName: 'Sepatu Lari', status: 'Diproses'),
      OrderModel(id: 'ORD003', productName: 'Kemeja Polos', status: 'Dikirim'),
      OrderModel(id: 'ORD004', productName: 'Jam Tangan', status: 'Selesai'),
      OrderModel(id: 'ORD005', productName: 'Tas Punggung', status: 'Selesai'),
    ];

    // Data Dummy Vouchers
    final vouchers = [
      VoucherModel(
        code: 'HEMAT20',
        discount: '20%',
        description: 'Diskon maksimal Rp20.000',
      ),
      VoucherModel(
        code: 'GRATISONGKIR',
        discount: '100%',
        description: 'Bebas ongkir seluruh Indonesia',
      ),
      VoucherModel(
        code: 'CASHOFF50',
        discount: '50%',
        description: 'Cashback khusus pengguna baru',
      ),
    ];

    // Hitung jumlah berdasarkan status
    final processingCount = orders.where((o) => o.status == 'Diproses').length;
    final shippingCount = orders.where((o) => o.status == 'Dikirim').length;
    final completedCount = orders.where((o) => o.status == 'Selesai').length;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Profil Saya',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProfileHeaderWidget(
              name: user.name,
              username: user.username,
              imageUrl: user.profileImage,
              onEditProfile: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            OrderStatusWidget(
              processingCount: processingCount,
              shippingCount: shippingCount,
              completedCount: completedCount,
              onProcessingTap: () => _navigateToOrders(context, 'Diproses'),
              onShippingTap: () => _navigateToOrders(context, 'Dikirim'),
              onCompletedTap: () => _navigateToOrders(context, 'Selesai'),
            ),
            const SizedBox(height: 16),
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
            MenuListWidget(
              onAddressTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddressScreen(),
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
                  MaterialPageRoute(builder: (context) => const HelpScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToOrders(BuildContext context, String statusFilter) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrdersScreen(initialStatusFilter: statusFilter),
      ),
    );
  }
}
