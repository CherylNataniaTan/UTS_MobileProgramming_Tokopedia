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
  // Durasi simulasi (detik). Ubah angka ini untuk demo.
  static const int shipAfterSeconds = 30;
  static const int doneAfterSeconds = 90;

  final String id;
  final String productName;

  String _status; // status manual (untuk order dummy / override)
  bool _autoProgress; // true = status dihitung otomatis dari waktu

  final String shopName;
  final List<OrderItem> items;
  final int shipping;
  final int total;
  final String paymentMethod;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.productName,
    String status = 'Diproses',
    bool autoProgress = false,
    this.shopName = 'UntarianMart',
    this.items = const [],
    this.shipping = 0,
    this.total = 0,
    this.paymentMethod = 'COD',
    DateTime? createdAt,
  })  : _status = status,
        _autoProgress = autoProgress,
        createdAt = createdAt ?? DateTime.now();

  /// Diproses, Dikirim, Selesai
  String get status {
    if (!_autoProgress) return _status;
    final s = DateTime.now().difference(createdAt).inSeconds;
    if (s < shipAfterSeconds) return 'Diproses';
    if (s < doneAfterSeconds) return 'Dikirim';
    return 'Selesai';
  }

  set status(String value) {
    _status = value;
    _autoProgress = false;
  }

  // Waktu tiap tahap, berguna untuk timeline di halaman detail
  DateTime get shippedAt =>
      createdAt.add(const Duration(seconds: shipAfterSeconds));
  DateTime get doneAt =>
      createdAt.add(const Duration(seconds: doneAfterSeconds));
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