import 'package:flutter/material.dart';
import '../data/untarpay_data.dart';
import 'untarpay_topup.dart';

class UntarPayScreen extends StatefulWidget {
  const UntarPayScreen({super.key});

  @override
  State<UntarPayScreen> createState() => _UntarPayScreenState();
}

class _UntarPayScreenState extends State<UntarPayScreen> {
  static const Color primaryMaroon = Color(0xFFA01626);
  static const Color darkMaroon = Color(0xFF700D1B);

  Future<void> openTopUp() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UntarPayTopUpScreen(),
      ),
    );

    if (result == true) {
      setState(() {});
    }
  }

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final transactions = UntarPayData.transactions;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: primaryMaroon,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'UntarPay',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    darkMaroon,
                    primaryMaroon,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Saldo UntarPay',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    UntarPayData.formattedBalance,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: openTopUp,
                      icon: const Icon(Icons.add),
                      label: const Text('Top Up'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: primaryMaroon,
                        padding: const EdgeInsets.symmetric(
                          vertical: 13,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Riwayat Transaksi',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: darkMaroon,
              ),
            ),

            const SizedBox(height: 10),

            if (transactions.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 35),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 45,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Belum ada transaksi',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: transactions.length,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 1,
                      indent: 70,
                    );
                  },
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 5,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: transaction.isTopUp
                            ? Colors.green.withOpacity(0.1)
                            : primaryMaroon.withOpacity(0.1),
                        child: Icon(
                          transaction.isTopUp
                              ? Icons.add
                              : Icons.shopping_bag_outlined,
                          color: transaction.isTopUp
                              ? Colors.green
                              : primaryMaroon,
                        ),
                      ),
                      title: Text(
                        transaction.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        formatDate(transaction.date),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      trailing: Text(
                        '${transaction.isTopUp ? '+' : '-'}${UntarPayData.formatAmount(transaction.amount)}',
                        style: TextStyle(
                          color: transaction.isTopUp
                              ? Colors.green
                              : primaryMaroon,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}