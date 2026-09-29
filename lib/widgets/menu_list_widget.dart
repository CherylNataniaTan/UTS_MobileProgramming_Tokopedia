import 'package:flutter/material.dart';
import 'account_menu_item_widget.dart';

class MenuListWidget extends StatelessWidget {
  final VoidCallback onAddressTap;
  final VoidCallback onSettingsTap;
  final VoidCallback onHelpTap;

  const MenuListWidget({
    super.key,
    required this.onAddressTap,
    required this.onSettingsTap,
    required this.onHelpTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          AccountMenuItemWidget(
            icon: Icons.location_on_outlined,
            title: 'Alamat Pengiriman',
            subtitle: 'Atur alamat pengiriman belanjaan',
            onTap: onAddressTap,
          ),
          const Divider(height: 1, indent: 56, endIndent: 16),
          AccountMenuItemWidget(
            icon: Icons.settings_outlined,
            title: 'Pengaturan Akun',
            subtitle: 'Keamanan, notifikasi, dan privasi',
            onTap: onSettingsTap,
          ),
          const Divider(height: 1, indent: 56, endIndent: 16),
          AccountMenuItemWidget(
            icon: Icons.help_outline,
            title: 'Pusat Bantuan',
            subtitle: 'Bantuan dan layanan pelanggan',
            onTap: onHelpTap,
          ),
        ],
      ),
    );
  }
}