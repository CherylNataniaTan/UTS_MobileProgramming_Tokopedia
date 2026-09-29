import 'package:flutter/material.dart';

class SellerInfoWidget extends StatelessWidget {
  final String sellerName;
  final String sellerLocation;

  const SellerInfoWidget({
    super.key,
    required this.sellerName,
    required this.sellerLocation,
  });

  static const Color green = Color(0xFF03AC0E);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.grey[200],
                child: const Icon(Icons.storefront, color: green),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            sellerName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.verified, size: 16, color: green),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Online',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 2),
                        Text(
                          sellerLocation,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: green,
                  side: const BorderSide(color: green),
                ),
                child: const Text('Follow'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Info tambahan toko (dummy)
          Row(
            children: [
              Icon(Icons.star, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              const Text('4.9', style: TextStyle(fontSize: 13)),
              Text(' rata-rata ulasan toko',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600])),
              const SizedBox(width: 16),
              Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text('± 1 jam pesanan diproses',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600])),
            ],
          ),
        ],
      ),
    );
  }
}