import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String description;
  final IconData icon;

  const NotificationItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static const Color primaryRed = Color(0xFFA01626);

  final List<NotificationItem> _notifications = const [
    NotificationItem(
      title: 'Pesananmu sedang dikirim',
      description: 'Paket kamu sedang dalam perjalanan ke alamat tujuan.',
      icon: Icons.local_shipping_outlined,
    ),
    NotificationItem(
      title: 'Flash Sale dimulai!',
      description: 'Buruan cek produk diskon sebelum kehabisan.',
      icon: Icons.bolt,
    ),
    NotificationItem(
      title: 'Voucher baru untukmu',
      description: 'Dapatkan diskon tambahan di halaman voucher promo.',
      icon: Icons.card_giftcard,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifikasi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryRed,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final item = _notifications[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: primaryRed.withOpacity(0.12),
                  child: Icon(item.icon, color: primaryRed, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.description,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}