import 'package:flutter/material.dart';
import '../models/order_model.dart';

class OrderDetailScreen extends StatefulWidget {
  final OrderModel order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  static const Color primaryRed = Color(0xFFA01626);
  static const Color darkRed = Color(0xFF700D1B);

  static const List<String> _steps = [
    'Pesanan Dibuat',
    'Diproses',
    'Dikirim',
    'Selesai',
  ];

  static const List<String> _stepDesc = [
    'Pesanan kamu sudah masuk',
    'Penjual sedang menyiapkan pesanan',
    'Pesanan dalam perjalanan ke alamat kamu',
    'Pesanan sudah sampai',
  ];

  int get currentStep {
    switch (widget.order.status) {
      case 'Diproses':
        return 1;
      case 'Dikirim':
        return 2;
      case 'Selesai':
        return 3;
      default:
        return 0;
    }
  }

  // buat demo: majuin status pesanan
  void nextStatus() {
    setState(() {
      if (widget.order.status == 'Diproses') {
        widget.order.status = 'Dikirim';
      } else if (widget.order.status == 'Dikirim') {
        widget.order.status = 'Selesai';
      }
    });
  }

  String _two(int n) => n.toString().padLeft(2, '0');

  String _formatDate(DateTime d) {
    return '${_two(d.day)}/${_two(d.month)}/${d.year} ${_two(d.hour)}:${_two(d.minute)}';
  }

  Widget _card({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: darkRed,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: const TextStyle(color: Colors.grey)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _timeline() {
    return Column(
      children: List.generate(_steps.length, (i) {
        final done = i <= currentStep;
        final isLast = i == _steps.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: done ? darkRed : Colors.grey[300],
                  child: Icon(
                    done ? Icons.check : Icons.circle,
                    size: done ? 14 : 6,
                    color: Colors.white,
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 40,
                    color: i < currentStep ? darkRed : Colors.grey[300],
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _steps[i],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: done ? darkRed : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _stepDesc[i],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final subtotal = order.total - order.shipping;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'Detail Transaksi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryRed,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _card(title: 'Status Pesanan', child: _timeline()),

          _card(
            title: 'Info Pesanan',
            child: Column(
              children: [
                _infoRow('ID Pesanan', order.id),
                _infoRow('Toko', order.shopName),
                _infoRow('Tanggal', _formatDate(order.createdAt)),
                _infoRow('Pembayaran', order.paymentMethod),
              ],
            ),
          ),

          _card(
            title: 'Produk',
            child: order.items.isEmpty
                ? Text(order.productName)
                : Column(
                    children: order.items.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                item.imageUrl,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  width: 50,
                                  height: 50,
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.image, color: Colors.grey),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.productName,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '${item.quantity} x Rp${formatRupiah(item.price)}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          ),

          if (order.total > 0)
            _card(
              title: 'Ringkasan Pembayaran',
              child: Column(
                children: [
                  _infoRow('Subtotal', 'Rp${formatRupiah(subtotal)}'),
                  _infoRow('Ongkir', 'Rp${formatRupiah(order.shipping)}'),
                  const Divider(),
                  Row(
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        'Rp${formatRupiah(order.total)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryRed,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
      bottomNavigationBar: order.status == 'Selesai'
          ? null
          : SafeArea(
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.white,
                child: OutlinedButton(
                  onPressed: nextStatus,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: primaryRed),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Simulasi: Lanjutkan Status',
                    style: TextStyle(color: primaryRed),
                  ),
                ),
              ),
            ),
    );
  }
}