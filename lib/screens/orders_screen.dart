import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  final String initialStatusFilter;

  const OrdersScreen({super.key, required this.initialStatusFilter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan Status: $initialStatusFilter'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text(
          'Menampilkan daftar pesanan dengan status: $initialStatusFilter',
        ),
      ),
    );
  }
}
