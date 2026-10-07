import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class ProductReview {
  final String name;
  final String username; // buat tahu ulasan ini milik siapa
  final int rating;
  final String comment;
  final int createdAt; // 0 = ulasan otomatis
  final String label; // teks waktu untuk ulasan otomatis

  const ProductReview({
    required this.name,
    required this.username,
    required this.rating,
    required this.comment,
    this.createdAt = 0,
    this.label = '',
  });

  String get timeAgo {
    if (createdAt == 0) return label;
    final diff = DateTime.now().difference(
      DateTime.fromMillisecondsSinceEpoch(createdAt),
    );
    if (diff.inMinutes < 1) return 'Baru saja';
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam lalu';
    return '${diff.inDays} hari lalu';
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'username': username,
        'rating': rating,
        'comment': comment,
        'createdAt': createdAt,
      };

  factory ProductReview.fromJson(Map<String, dynamic> j) => ProductReview(
        name: j['name'] ?? 'Pengguna',
        username: j['username'] ?? '',
        rating: (j['rating'] as num?)?.toInt() ?? 5,
        comment: j['comment'] ?? '',
        createdAt: (j['createdAt'] as num?)?.toInt() ?? 0,
      );
}

class ReviewService {
  static String _key(String productId) => 'user_reviews_$productId';


  static Future<List<ProductReview>> getUserReviews(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key(productId));
    if (raw == null) return [];
    return (jsonDecode(raw) as List)
        .map((e) => ProductReview.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  static Future<void> _save(String productId, List<ProductReview> list) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key(productId),
      jsonEncode(list.map((e) => e.toJson()).toList()),
    );
  }

  static Future<void> saveReview(String productId, ProductReview r) async {
    final list = await getUserReviews(productId);
    list.removeWhere((e) => e.username == r.username);
    list.insert(0, r);
    await _save(productId, list);
  }

  static Future<void> deleteReview(String productId, String username) async {
    final list = await getUserReviews(productId);
    list.removeWhere((e) => e.username == username);
    await _save(productId, list);
  }


  static const _names = [
    'Budi Santoso', 'Siti Rahayu', 'Andi Wijaya', 'Dewi Lestari',
    'Rizky Ramadhan', 'Putri Ayu', 'Agus Setiawan', 'Nur Aini',
    'Fajar Nugroho', 'Maya Sari', 'Hendra Gunawan', 'Rina Marlina',
    'Yoga Pratama', 'Intan Permata', 'Dimas Prakoso', 'Lia Anggraini',
    'Eko Prasetyo', 'Anisa Fitri', 'Bayu Saputra', 'Citra Kirana',
    'Rudi Hartono', 'Wulan Dari', 'Galih Pangestu', 'Tika Amelia',
  ];

  static const _times = [
    '2 hari lalu', '5 hari lalu', '1 minggu lalu', '2 minggu lalu',
    '3 minggu lalu', '1 bulan lalu', '2 bulan lalu', '3 bulan lalu',
    '5 bulan lalu', '8 bulan lalu',
  ];

  static const Map<int, List<String>> _comments = {
    5: [
      'Barang sesuai deskripsi, packing rapi dan aman. Pengiriman cepat, recommended seller!',
      'Kualitas bagus banget, sesuai dengan harganya. Pasti beli lagi di sini.',
      'Barang sampai dengan selamat, penjual ramah dan fast respon. Terima kasih!',
      'Mantap! Barangnya original dan kualitasnya oke banget.',
      'Pengiriman super cepat, barang sesuai foto. Puas banget belanja di sini.',
      'Sudah langganan beli di toko ini, tidak pernah mengecewakan.',
      'Packing bubble wrap tebal, barang aman sampai tujuan. Top deh!',
      'Bagus banget barangnya, lebih bagus dari yang aku bayangkan.',
    ],
    4: [
      'Barang bagus, sesuai deskripsi. Cuma pengirimannya agak lama sedikit.',
      'Kualitas oke untuk harga segini. Packing bisa lebih rapi lagi.',
      'Secara keseluruhan puas, cuma warnanya sedikit beda dari foto.',
      'Barang sudah sampai dan berfungsi dengan baik. Lumayan lah.',
      'Sesuai harga, tidak ada cacat. Semoga awet pemakaiannya.',
      'Bagus, penjual juga responsif. Kurang satu bintang karena kurirnya telat.',
    ],
    3: [
      'Barangnya biasa saja, sesuai harga lah. Pengiriman standar.',
      'Kualitas lumayan tapi tidak sebagus yang ada di foto.',
      'Cukup oke, ada sedikit lecet di bagian luar tapi masih bisa dipakai.',
      'Standar, tidak jelek tapi juga tidak istimewa.',
      'Barang sampai agak lama, kualitasnya biasa aja.',
    ],
    2: [
      'Kurang puas, barang tidak seperti yang dideskripsikan.',
      'Packing kurang aman, dus agak penyok waktu sampai.',
      'Kualitasnya di bawah ekspektasi, kecewa sedikit.',
      'Pengiriman lama banget, barangnya pun biasa saja.',
    ],
    1: [
      'Sangat kecewa, barang tidak sesuai dan kualitasnya jelek.',
      'Barang rusak waktu sampai, mohon respon penjualnya.',
      'Tidak recommended, jauh berbeda dari foto produk.',
      'Pesanan lama sampai dan kondisinya buruk. Tidak akan beli lagi.',
    ],
  };

  static List<ProductReview> generated(String productId, double baseRating) {
    final seed =
        int.tryParse(productId) ?? productId.codeUnits.fold<int>(0, (a, b) => a + b);
    final rnd = Random(seed);

    final count = 10 + rnd.nextInt(8); // 10 - 17 ulasan
    final names = List<String>.from(_names)..shuffle(rnd);
    final timeIdx = List.generate(count, (_) => rnd.nextInt(_times.length))
      ..sort();

    final used = <String>{};
    final result = <ProductReview>[];

    for (int i = 0; i < count; i++) {
      final rating =
          (baseRating + (rnd.nextDouble() * 2.4 - 1.2)).round().clamp(1, 5).toInt();
      final pool = _comments[rating]!;

      var comment = pool[rnd.nextInt(pool.length)];
      for (int t = 0; t < 10 && used.contains(comment); t++) {
        comment = pool[rnd.nextInt(pool.length)];
      }
      used.add(comment);

      result.add(ProductReview(
        name: names[i],
        username: 'auto_$i',
        rating: rating,
        comment: comment,
        label: _times[timeIdx[i]],
      ));
    }
    return result;
  }
}