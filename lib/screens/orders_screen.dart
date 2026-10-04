import 'package:flutter/material.dart';
import '../models/order_model.dart';

class OrdersScreen extends StatelessWidget {
  final String initialStatusFilter;
  final List<OrderModel> orders;

  const OrdersScreen({
    super.key,
    required this.initialStatusFilter,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    // Filter pesanan berdasarkan status yang dipilih
    final filteredOrders = orders
        .where((order) => order.status == initialStatusFilter)
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Pesanan Status: $initialStatusFilter',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 112, 13, 27),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: filteredOrders.isEmpty
          ? Center(
              child: Text(
                'Tidak ada pesanan dengan status "$initialStatusFilter"',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                final order = filteredOrders[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 112, 13, 27),
                      child: Icon(Icons.shopping_bag, color: Colors.white),
                    ),
                    title: Text(
                      order.productName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('ID Pesanan: ${order.id}'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        order.status,
                        style: TextStyle(
                          color: Colors.amber[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}