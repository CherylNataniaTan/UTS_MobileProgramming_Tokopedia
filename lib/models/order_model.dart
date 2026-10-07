class OrderModel {
  final String id;
  final String productName;
  final String status;

  OrderModel({
    required this.id,
    required this.productName,
    required this.status,
  });
}

final List<OrderModel> dummyOrders = [
  OrderModel(id: 'ORD001', productName: 'Wireless Earphone', status: 'Diproses'),
  OrderModel(id: 'ORD002', productName: 'Sepatu Lari', status: 'Diproses'),
  OrderModel(id: 'ORD003', productName: 'Kemeja Polos', status: 'Dikirim'),
  OrderModel(id: 'ORD004', productName: 'Jam Tangan', status: 'Selesai'),
  OrderModel(id: 'ORD005', productName: 'Tas Punggung', status: 'Selesai'),
];