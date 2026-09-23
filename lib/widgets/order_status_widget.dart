import 'package:flutter/material.dart';

class OrderStatusWidget extends StatelessWidget {
  final int processingCount;
  final int shippingCount;
  final int completedCount;
  final VoidCallback onProcessingTap;
  final VoidCallback onShippingTap;
  final VoidCallback onCompletedTap;

  const OrderStatusWidget({
    super.key,
    required this.processingCount,
    required this.shippingCount,
    required this.completedCount,
    required this.onProcessingTap,
    required this.onShippingTap,
    required this.onCompletedTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pesanan Saya',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildOrderItem(
                icon: Icons.sync,
                label: 'Diproses',
                count: processingCount,
                onTap: onProcessingTap,
              ),
              _buildOrderItem(
                icon: Icons.local_shipping_outlined,
                label: 'Dikirim',
                count: shippingCount,
                onTap: onShippingTap,
              ),
              _buildOrderItem(
                icon: Icons.check_circle_outline,
                label: 'Selesai',
                count: completedCount,
                onTap: onCompletedTap,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem({
    required IconData icon,
    required String label,
    required int count,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, size: 28, color: Colors.green[800]),
                if (count > 0)
                  Positioned(
                    right: -6,
                    top: -6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '$count',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}