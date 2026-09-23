import 'package:flutter/material.dart';

class ProductInfoWidget extends StatelessWidget {
  final String name;
  final double price;
  final int sold;

  const ProductInfoWidget({
    super.key,
    required this.name,
    required this.price,
    required this.sold,
  });

  // Fungsi buat format harga jadi "Rp1.000.000"
  String _formatPrice(double price) {
    String priceStr = price.toInt().toString();
    String result = '';
    int count = 0;

    for (int i = priceStr.length - 1; i >= 0; i--) {
      result = priceStr[i] + result;
      count++;
      if (count % 3 == 0 && i != 0) {
        result = '.$result';
      }
    }
    return 'Rp$result';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            _formatPrice(price),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Terjual $sold+',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}