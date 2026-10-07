import 'package:flutter/material.dart';

class OrderSummaryWidget extends StatelessWidget {
  final int subtotal;
  final int productDiscount;
  final int shipping;
  final int shippingDiscount;
  final int voucherDiscount;

  const OrderSummaryWidget({
    super.key,
    required this.subtotal,
    required this.productDiscount,
    required this.shipping,
    required this.shippingDiscount,
    required this.voucherDiscount,
  });

  @override
  Widget build(BuildContext context) {
    final int total = subtotal -
        productDiscount +
        shipping -
        shippingDiscount -
        voucherDiscount;

    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rincian Pembayaran',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal Produk'),
              Text('Rp$subtotal'),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Diskon Produk'),
              Text(
                '-Rp$productDiscount',
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Ongkos Kirim'),
              Text('Rp$shipping'),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Diskon Pengiriman'),
              Text(
                '-Rp$shippingDiscount',
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Voucher Diskon'),
              Text(
                '-Rp$voucherDiscount',
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),

          const Divider(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Pembayaran',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Rp$total',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}