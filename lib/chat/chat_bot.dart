import '../models/product.dart';


String getBotReply(String userText, {Product? product}) {
  final text = userText.toLowerCase();
  final productName = product?.name;

  bool has(List<String> keywords) {
    for (final keyword in keywords) {
      if (text.contains(keyword)) {
        return true;
      }
    }
    return false;
  }

  if (has(['ready', 'stok', 'stock', 'tersedia', 'ada'])) {
    if (productName != null) {
      return 'Halo kak, $productName ready ya. Stoknya masih banyak, '
          'silakan langsung diorder.';
    }
    return 'Halo kak, barangnya ready ya. Silakan langsung diorder.';
  }

  if (has(['kirim', 'ongkir', 'sampai', 'estimasi', 'pengiriman'])) {
    return 'Pesanan yang masuk sebelum jam 15.00 kami kirim di hari yang '
        'sama kak. Ongkir mulai Rp9.000, estimasi tiba 2 - 4 hari.';
  }

  if (has(['diskon', 'promo', 'murah', 'nego', 'potongan'])) {
    return 'Harga di toko kami sudah harga terbaik kak. Cek juga voucher '
        'yang tersedia di halaman checkout ya.';
  }

  if (has(['asli', 'original', 'ori', 'garansi', 'bagus'])) {
    return 'Semua produk di toko kami 100% original dan bergaransi kak.';
  }

  if (has(['terima kasih', 'makasih', 'thanks', 'thx'])) {
    return 'Sama-sama kak, terima kasih sudah berbelanja di toko kami.';
  }

  if (has(['hai', 'halo', 'hallo', 'hello', 'pagi', 'siang', 'sore', 'malam'])) {
    return 'Halo kak, ada yang bisa kami bantu?';
  }

  // pesan cuma "p" atau "tes"
  if (text.trim() == 'p' || has(['tes', 'test'])) {
    return 'Halo kak, ada yang bisa kami bantu?';
  }

  return 'Baik kak, pesannya sudah kami terima. Mohon ditunggu ya, admin '
      'kami akan segera membalas.';
}

String getProductOnlyReply(Product product) {
  return 'Halo kak, ada yang ingin ditanyakan soal ${product.name}?';
}