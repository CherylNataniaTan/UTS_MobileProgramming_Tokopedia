import 'package:flutter/material.dart';

import '../models/order_model.dart';
import '../widgets/ticker_builder_widget.dart';
import 'order_detail_screen.dart';

class OrdersScreen extends StatefulWidget {
  final String initialStatusFilter;
  final List<OrderModel> orders;

  const OrdersScreen({
    super.key,
    this.initialStatusFilter = 'Semua',
    required this.orders,
  });

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  static const Color darkRed = Color(0xFF700D1B);
  static const List<String> _filters = [
    'Semua',
    'Diproses',
    'Dikirim',
    'Selesai',
  ];

  late String _selectedFilter;

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.initialStatusFilter;
  }

  Color _statusBg(String status) {
    if (status == 'Selesai') return Colors.green[100]!;
    if (status == 'Dikirim') return Colors.blue[100]!;
    return Colors.amber[100]!;
  }

  Color _statusFg(String status) {
    if (status == 'Selesai') return Colors.green[900]!;
    if (status == 'Dikirim') return Colors.blue[900]!;
    return Colors.amber[900]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Transaksi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: darkRed,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // TickerBuilder: rebuild tiap detik supaya status real-time
      body: TickerBuilder(
        builder: (context) {
          final filteredOrders = _selectedFilter == 'Semua'
              ? widget.orders
              : widget.orders
                    .where((o) => o.status == _selectedFilter)
                    .toList();

          return Column(
            children: [
              SizedBox(
                height: 56,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  itemCount: _filters.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final f = _filters[index];
                    final selected = f == _selectedFilter;
                    return ChoiceChip(
                      label: Text(f),
                      selected: selected,
                      showCheckmark: false,
                      selectedColor: darkRed,
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : Colors.grey[700],
                        fontWeight: selected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                      onSelected: (_) => setState(() => _selectedFilter = f),
                    );
                  },
                ),
              ),
              Expanded(
                child: filteredOrders.isEmpty
                    ? Center(
                        child: Text(
                          _selectedFilter == 'Semua'
                              ? 'Belum ada pesanan'
                              : 'Tidak ada pesanan dengan status "$_selectedFilter"',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                        itemCount: filteredOrders.length,
                        itemBuilder: (context, index) {
                          final order = filteredOrders[index];
                          final status = order.status;
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OrderDetailScreen(order: order),
                                  ),
                                );
                                // refresh, siapa tau status berubah di halaman detail
                                setState(() {});
                              },
                              isThreeLine: order.total > 0,
                              leading: const CircleAvatar(
                                backgroundColor: darkRed,
                                child: Icon(
                                  Icons.shopping_bag,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                order.productName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                order.total > 0
                                    ? 'ID Pesanan: ${order.id}\nTotal Rp${formatRupiah(order.total)}'
                                    : 'ID Pesanan: ${order.id}',
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _statusBg(status),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    color: _statusFg(status),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
