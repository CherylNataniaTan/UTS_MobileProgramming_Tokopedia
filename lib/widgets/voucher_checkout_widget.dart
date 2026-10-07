import 'package:flutter/material.dart';

import '../models/voucher_model.dart';

class VoucherCheckoutWidget extends StatelessWidget {
  final VoucherModel? selectedVoucher;
  final VoidCallback onTap;

  const VoucherCheckoutWidget({
    super.key,
    required this.selectedVoucher,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryRed = Color(0xFFA01626);

    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            const Icon(
              Icons.confirmation_num,
              color: primaryRed,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Voucher',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  if (selectedVoucher == null)
                    const Text(
                      'Pilih voucher',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  else ...[
                    Text(
                      selectedVoucher!.code,
                      style: const TextStyle(
                        color: primaryRed,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      selectedVoucher!.description,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}