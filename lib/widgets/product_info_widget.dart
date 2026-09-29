import 'package:flutter/material.dart';

class ProductInfoWidget extends StatelessWidget {
  final String name;
  final int price;

  const ProductInfoWidget({
    super.key,
    required this.name,
    required this.price,
  });

  // Fungsi buat format harga jadi "Rp1.000.000"
  String _formatPrice(int price) {
    String priceStr = price.toString();
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
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _formatPrice(price),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: const TextStyle(
              fontSize: 15,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}