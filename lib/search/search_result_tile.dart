import 'package:flutter/material.dart';
import '../models/product.dart';

class SearchResultTile extends StatelessWidget {
  final Product product;

  const SearchResultTile({
    super.key,
    required this.product,
  });

  static const Color primaryRed = Color(0xFFA01626);
  static const Color darkRed = Color(0xFF700D1B);
  static const Color gray = Color(0xFF575757);
  static const Color orange = Color(0xFFE89D2D);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            product.imageUrl,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          product.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: darkRed,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Rp${product.price}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryRed,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  size: 14,
                  color: orange,
                ),
                const SizedBox(width: 4),
                Text(
                  '${product.rating}',
                  style: const TextStyle(
                    color: gray,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}