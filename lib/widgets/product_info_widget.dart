import 'package:flutter/material.dart';

class ProductInfoWidget extends StatelessWidget {
  final String name;
  final int price; // harga setelah diskon
  final int? originalPrice; // harga asli (sebelum diskon)
  final double discountPercentage;

  const ProductInfoWidget({
    super.key,
    required this.name,
    required this.price,
    this.originalPrice,
    this.discountPercentage = 0,
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
    final hasDiscount = discountPercentage > 0 &&
        originalPrice != null &&
        originalPrice! > price;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Harga setelah diskon
          Text(
            _formatPrice(price),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Badge diskon + harga coret
          if (hasDiscount) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE3E8),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${discountPercentage.round()}%',
                    style: const TextStyle(
                      color: Color(0xFFE5173F),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _formatPrice(originalPrice!),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ],

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