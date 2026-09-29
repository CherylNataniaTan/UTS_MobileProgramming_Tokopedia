import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final int sold;

  const RatingWidget({
    super.key,
    required this.rating,
    required this.reviewCount,
    required this.sold,
  });

  // Angka ribuan dijadiin "rb", contoh 3200 -> "3,2rb"
  String _shorten(int n) {
    if (n >= 1000) {
      String rb = (n / 1000).toStringAsFixed(1);
      if (rb.endsWith('.0')) {
        rb = rb.substring(0, rb.length - 2);
      }
      return '${rb.replaceAll('.', ',')}rb';
    }
    return '$n';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Row(
        children: [
          Text(
            'Terjual ${_shorten(sold)}+',
            style: TextStyle(color: Colors.grey[700], fontSize: 13),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('•', style: TextStyle(color: Colors.grey[500])),
          ),
          const Icon(Icons.star, color: Colors.amber, size: 16),
          const SizedBox(width: 2),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(width: 4),
          Text(
            '(${_shorten(reviewCount)} rating)',
            style: TextStyle(color: Colors.grey[700], fontSize: 13),
          ),
        ],
      ),
    );
  }
}