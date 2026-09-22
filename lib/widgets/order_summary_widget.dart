import 'package:flutter/material.dart';

class OrderSummaryWidget extends StatelessWidget {
  final int subtotal;
  final int shipping;
  final int discount;

  const OrderSummaryWidget({
    super.key,
    required this.subtotal,
    required this.shipping,
    required this.discount,
  });

   @override
  Widget build(BuildContext context) {
    int total = subtotal + shipping - discount;
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
              const Text('Ongkos Kirim'),
              Text('Rp$shipping'),
            ],
          ),
           const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Diskon'),
              Text(
                '-Rp$discount',
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
