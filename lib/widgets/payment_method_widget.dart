import 'package:flutter/material.dart';
import '../data/untarpay_data.dart';

class PaymentMethodWidget extends StatelessWidget {
  final String selectedMethod;
  final Function(String) onChanged;

  const PaymentMethodWidget({
    super.key,
    required this.selectedMethod,
    required this.onChanged,
  });

  static const Color primaryRed = Color(0xFFA01626);
  static const Color darkRed = Color(0xFF700D1B);
  static const Color untarPurple = Color(0xFF5B2C83);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryRed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: primaryRed,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Metode Pembayaran',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: darkRed,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // UntarPay
          _buildPaymentCard(
            value: 'UntarPay',
            title: 'UntarPay',
            subtitle: 'Saldo ${UntarPayData.formattedBalance}',
            icon: Icons.account_balance_wallet,
            iconColor: untarPurple,
            isSpecial: true,
          ),

          const SizedBox(height: 10),

          // Transfer Bank
          _buildPaymentCard(
            value: 'Transfer Bank',
            title: 'Transfer Bank',
            subtitle: 'BCA',
            icon: Icons.account_balance,
            iconColor: Colors.blue,
          ),

<<<<<<< HEAD
          const SizedBox(height: 10),

          // E-Wallet
          _buildPaymentCard(
=======
          RadioListTile<String>(
            title: const Text('E-Wallet'),
            subtitle: const Text('UntarPay'),
>>>>>>> 0a382f3615f643065adf20e2c4ebb87acda29df4
            value: 'E-Wallet',
            title: 'E-Wallet',
            subtitle: 'GoPay',
            icon: Icons.phone_android,
            iconColor: Colors.green,
          ),

          const SizedBox(height: 10),

          // COD
          _buildPaymentCard(
            value: 'COD',
            title: 'COD',
            subtitle: 'Bayar di tempat',
            icon: Icons.payments_outlined,
            iconColor: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard({
    required String value,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    bool isSpecial = false,
  }) {
    final bool isSelected = selectedMethod == value;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        onChanged(value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: isSelected
              ? iconColor.withOpacity(0.07)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? iconColor
                : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 23,
              ),
            ),

            const SizedBox(width: 12),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      if (isSpecial) ...[
                        const SizedBox(width: 7),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: untarPurple,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            'REKOMENDASI',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 3),

                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            // Check
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? iconColor
                      : Colors.grey.shade400,
                  width: 1.5,
                ),
                color: isSelected
                    ? iconColor
                    : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

