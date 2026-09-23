import 'package:flutter/material.dart';

class VoucherWidget extends StatelessWidget {
  final int voucherCount;
  final VoidCallback onTap;

  const VoucherWidget({
    super.key,
    required this.voucherCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasVouchers = voucherCount > 0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.confirmation_number_outlined,
              color: hasVouchers ? Colors.green[800] : Colors.grey,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Voucher Saya',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    hasVouchers
                        ? '$voucherCount voucher tersedia'
                        : 'Belum ada voucher tersedia',
                    style: TextStyle(
                      fontSize: 12,
                      color: hasVouchers ? Colors.green[800] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  'Lihat Voucher',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.green[800],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.green[800],
                  size: 18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}