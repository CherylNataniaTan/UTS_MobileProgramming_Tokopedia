import 'package:flutter/material.dart';

class PaymentMethodWidget extends StatelessWidget {
  final String selectedMethod;
  final Function(String) onChanged;

  const PaymentMethodWidget({
    super.key,
    required this.selectedMethod,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Metode Pembayaran',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          RadioListTile<String>(
            title: const Text('Transfer Bank'),
            subtitle: const Text('Bank BCA'),
            value: 'Transfer Bank',
            // ignore: deprecated_member_use
            groupValue: selectedMethod,
            // ignore: deprecated_member_use
            onChanged: (value) {
              onChanged(value!);
            },
          ),

          RadioListTile<String>(
            title: const Text('E-Wallet'),
            subtitle: const Text('GoPay'),
            value: 'E-Wallet',
            // ignore: deprecated_member_use
            groupValue: selectedMethod,
            // ignore: deprecated_member_use
            onChanged: (value) {
              onChanged(value!);
            },
          ),

          RadioListTile<String>(
            title: const Text('COD'),
            subtitle: const Text('Bayar di tempat'),
            value: 'COD',
            // ignore: deprecated_member_use
            groupValue: selectedMethod,
            // ignore: deprecated_member_use
            onChanged: (value) {
              onChanged(value!);
            },
          ),
        ],
      ),
    );
  }
}