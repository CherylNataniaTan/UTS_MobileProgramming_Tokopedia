import 'package:flutter/material.dart';
import '../models/voucher_model.dart';

class VoucherScreen extends StatelessWidget {
  final List<VoucherModel> vouchers;

  const VoucherScreen({super.key, required this.vouchers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Voucher Saya'), backgroundColor: Color.from(alpha: 1, red: 0.439, green: 0.051, blue: 0.106),),
      body: vouchers.isEmpty
          ? const Center(child: Text('Belum Ada Voucher'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: vouchers.length,
              itemBuilder: (context, index) {
                final v = vouchers[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.confirmation_number, color: Color.from(alpha: 1, red: 0.439, green: 0.051, blue: 0.106),),
                    title: Text('${v.code} (${v.discount})'),
                    subtitle: Text(v.description),
                  ),
                );
              },
            ),
    );
  }
}