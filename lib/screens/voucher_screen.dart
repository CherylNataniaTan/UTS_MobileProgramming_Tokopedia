import 'package:flutter/material.dart';
import '../models/voucher_model.dart';

class VoucherScreen extends StatelessWidget {
  final List<VoucherModel> vouchers;

  const VoucherScreen({super.key, required this.vouchers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voucher Saya'), backgroundColor: Colors.green),
      body: vouchers.isEmpty
          ? const Center(child: Text('Belum Ada Voucher'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: vouchers.length,
              itemBuilder: (context, index) {
                final v = vouchers[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.confirmation_number, color: Colors.green),
                    title: Text('${v.code} (${v.discount})'),
                    subtitle: Text(v.description),
                  ),
                );
              },
            ),
    );
  }
}