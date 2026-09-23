import 'package:flutter/material.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alamat Pengiriman'), backgroundColor: Colors.green),
      body: const Center(child: Text('Akan segera hadir fitur pengelolaan alamat pengiriman.')),
    );
  }
}