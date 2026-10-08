import 'package:flutter/material.dart';

import '../models/order_model.dart';
import 'chat_bot_screen.dart';
import 'orders_screen.dart';

class HelpScreen extends StatelessWidget {
  final List<OrderModel> orders;

  const HelpScreen({super.key, this.orders = const []});

  static const Color primaryRed = Color(0xFFA01626);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Pusat Bantuan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryRed,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Layanan Cepat',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryRed,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrdersScreen(
                    orders: orders,
                    initialStatusFilter: 'Semua',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.local_shipping),
            label: const Text('Cek Status Pengiriman Pesanan'),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryRed,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 24),

          //faq
          const Text(
            'Pertanyaan Populer (FAQ)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryRed,
            ),
          ),
          const SizedBox(height: 12),
          _buildFaqAccordion(
            'Kenapa saya mengalami kendala saat checkout?',
            'Pastikan koneksi internet Anda stabil, alamat pengiriman sudah lengkap, dan metode pembayaran yang dipilih valid.',
          ),
          _buildFaqAccordion(
            'Bagaimana cara melacak pesanan saya?',
            'Anda dapat menekan tombol "Cek Status Pengiriman Pesanan" di atas untuk langsung membuka daftar transaksi Anda.',
          ),
          _buildFaqAccordion(
            'Berapa lama proses pengembalian dana (refund)?',
            'Proses pengembalian dana memakan waktu 3-5 hari kerja tergantung metode pembayaran yang Anda gunakan.',
          ),
          const SizedBox(height: 24),

          //bot
          const Text(
            'Hubungi Kami',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryRed,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: primaryRed,
                child: Icon(Icons.support_agent, color: Colors.white),
              ),
              title: const Text(
                'Chat Prioritas (Live Bot)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'Dapatkan solusi instan dari asisten virtual kami.',
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.grey),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatBotScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqAccordion(String question, String answer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10.0),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        iconColor: primaryRed,
        collapsedIconColor: Colors.grey,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey.shade50,
            width: double.infinity,
            child: Text(
              answer,
              style: TextStyle(color: Colors.grey.shade800, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
