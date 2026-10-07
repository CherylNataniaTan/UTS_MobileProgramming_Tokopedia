import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'cart_screen.dart';
import 'Profile_Screen.dart';
import 'orders_screen.dart';
import 'voucher_screen.dart';
import 'flash_sale_screen.dart';
import '../category/category_screen.dart';
import '../models/voucher_model.dart';
import '../models/order_model.dart';

final List<VoucherModel> dummyVouchers = [
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

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  static const Color primaryRed = Color(0xFFA01626);

  int _selectedTabIndex = 0;

  final List<Widget> _tabs = [
    const HomeScreen(),
    VoucherScreen(vouchers: dummyVouchers),
    const FlashSaleScreen(),
    OrdersScreen(orders: dummyOrders),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedTabIndex,
        children: _tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        selectedItemColor: primaryRed,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Voucher',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt),
            label: 'Sale',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedTabIndex = index;
          });
        },
      ),
    );
  }
}