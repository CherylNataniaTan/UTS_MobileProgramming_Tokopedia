class OrderItem {
  final String productName;
  final String imageUrl;
  final int price;
  final int quantity;

  const OrderItem({
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });
}

class OrderModel {
  final String id;
  final String productName;
  String status; // Diproses, Dikirim, Selesai

  final String shopName;
  final List<OrderItem> items;
  final int shipping;
  final int total;
  final String paymentMethod;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.productName,
    required this.status,
    this.shopName = 'UntarianMart',
    this.items = const [],
    this.shipping = 0,
    this.total = 0,
    this.paymentMethod = 'COD',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

String formatRupiah(int value) {
  return value.toString().replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'),
        (match) => '.',
      );
}

String generateOrderId() {
  return 'ORD${(dummyOrders.length + 1).toString().padLeft(3, '0')}';
}

final List<OrderModel> dummyOrders = [
  OrderModel(id: 'ORD001', productName: 'Wireless Earphone', status: 'Diproses'),
  OrderModel(id: 'ORD002', productName: 'Sepatu Lari', status: 'Diproses'),
  OrderModel(id: 'ORD003', productName: 'Kemeja Polos', status: 'Dikirim'),
  OrderModel(id: 'ORD004', productName: 'Jam Tangan', status: 'Selesai'),
  OrderModel(id: 'ORD005', productName: 'Tas Punggung', status: 'Selesai'),
];