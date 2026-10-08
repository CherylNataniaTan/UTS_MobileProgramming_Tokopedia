import '../models/product.dart';

String categoryLabel(String category) {
  const labels = {
    'beauty': 'Kecantikan',
    'skin-care': 'Perawatan Kulit',
    'fragrances': 'Parfum',
    'furniture': 'Furnitur',
    'groceries': 'Bahan Makanan',
    'home-decoration': 'Dekorasi Rumah',
    'kitchen-accessories': 'Perlengkapan Dapur',
    'laptops': 'Laptop',
    'smartphones': 'Ponsel',
    'tablets': 'Tablet',
    'mobile-accessories': 'Aksesori Ponsel',
    'mens-shirts': 'Kemeja Pria',
    'mens-shoes': 'Sepatu Pria',
    'mens-watches': 'Jam Tangan Pria',
    'womens-bags': 'Tas Wanita',
    'womens-dresses': 'Dress Wanita',
    'womens-jewellery': 'Perhiasan Wanita',
    'womens-shoes': 'Sepatu Wanita',
    'womens-watches': 'Jam Tangan Wanita',
    'tops': 'Atasan',
    'sunglasses': 'Kacamata',
    'sports-accessories': 'Aksesori Olahraga',
    'motorcycle': 'Motor',
    'vehicle': 'Kendaraan',
  };
  return labels[category] ?? category;
}


String _group(String category) {
  switch (category) {
    case 'beauty':
    case 'skin-care':
      return 'kecantikan';
    case 'fragrances':
      return 'parfum';
    case 'furniture':
    case 'home-decoration':
    case 'kitchen-accessories':
      return 'rumah';
    case 'groceries':
      return 'groceries';
    case 'laptops':
    case 'smartphones':
    case 'tablets':
    case 'mobile-accessories':
      return 'elektronik';
    case 'mens-shirts':
    case 'tops':
    case 'womens-dresses':
      return 'fashion';
    case 'mens-shoes':
    case 'womens-shoes':
      return 'sepatu';
    case 'mens-watches':
    case 'womens-watches':
    case 'womens-jewellery':
    case 'womens-bags':
    case 'sunglasses':
      return 'aksesori';
    case 'motorcycle':
    case 'vehicle':
      return 'otomotif';
    case 'sports-accessories':
      return 'olahraga';
    default:
      return 'umum';
  }
}


List<String> buildDescription(Product product) {
  final nama = product.name;
  final brand = product.sellerName;
  final lokasi = product.sellerLocation;

  final List<String> isi;

  switch (_group(product.category)) {
    case 'kecantikan':
      isi = [
        '$nama dari $brand adalah produk perawatan dan kecantikan yang dirancang untuk membantu kamu tampil lebih percaya diri setiap hari. Formulanya ringan dan nyaman dipakai, jadi cocok dipakai seharian tanpa terasa berat di kulit.',
        'Produk ini punya hasil akhir yang natural dan mudah dipadukan dengan rangkaian kecantikan lain yang sudah kamu punya. Tekstur dan warnanya dibuat supaya gampang diaplikasikan, bahkan untuk kamu yang baru mulai mencoba.',
        'Cara pakai: gunakan secukupnya sesuai kebutuhan dan ratakan dengan lembut. Bersihkan wajah terlebih dahulu sebelum pemakaian, dan simpan di tempat sejuk, kering, serta terhindar dari sinar matahari langsung. Hentikan pemakaian jika timbul rasa tidak nyaman pada kulit.',
      ];
      break;
    case 'parfum':
      isi = [
        '$nama dari $brand adalah parfum dengan aroma yang elegan dan berkarakter. Kombinasi wanginya dibuat agar tetap menyenangkan dari semprotan pertama sampai beberapa jam setelahnya.',
        'Aromanya cocok dipakai untuk berbagai suasana, mulai dari aktivitas harian, kerja, sampai acara spesial. Kemasannya juga rapi dan menarik, sehingga pantas dijadikan hadiah untuk orang terdekat.',
        'Tips pemakaian: semprotkan pada titik nadi seperti pergelangan tangan dan leher dari jarak sekitar 15 cm. Jangan digosok agar aroma tahan lebih lama. Simpan jauh dari panas dan cahaya langsung supaya kualitas wanginya terjaga.',
      ];
      break;
    case 'rumah':
      isi = [
        '$nama dari $brand adalah perlengkapan rumah yang memadukan fungsi dan tampilan. Desainnya sederhana namun rapi, sehingga mudah dipadukan dengan berbagai gaya ruangan.',
        'Dibuat dari bahan yang kokoh dan dikerjakan dengan cukup detail, produk ini nyaman dipakai dalam kegiatan sehari-hari dan tahan untuk pemakaian jangka panjang. Ukurannya pas untuk rumah, kos, maupun apartemen.',
        'Perawatan: bersihkan secara berkala dengan kain lembut yang sedikit lembap, lalu keringkan. Hindari benda tajam dan bahan pembersih yang keras supaya permukaannya tetap awet dan terlihat baru.',
      ];
      break;
    case 'groceries':
      isi = [
        '$nama dari $brand adalah kebutuhan harian yang dipilih dengan baik untuk keluarga. Produk dikemas dengan rapi supaya kualitas dan kesegarannya tetap terjaga sampai ke tangan kamu.',
        'Cocok untuk stok di rumah maupun kebutuhan memasak sehari-hari. Kualitasnya konsisten, jadi aman dijadikan pilihan langganan.',
        'Penyimpanan: simpan di tempat yang sejuk dan kering, jauh dari sinar matahari langsung. Pastikan kemasan tertutup rapat setelah dibuka, dan periksa tanggal kedaluwarsa pada kemasan sebelum dikonsumsi.',
      ];
      break;
    case 'elektronik':
      isi = [
        '$nama dari $brand adalah perangkat elektronik yang dirancang untuk menunjang aktivitas harian, baik untuk belajar, bekerja, maupun hiburan. Performanya stabil dan responsif untuk kebutuhan sehari-hari.',
        'Desainnya ringkas dan nyaman dibawa ke mana saja. Kualitas bahan dan rakitannya dijaga agar tahan untuk pemakaian jangka panjang, dan mudah dipadukan dengan perangkat atau aksesori lain.',
        'Catatan: gunakan charger dan kabel yang sesuai standar, hindari pemakaian di tempat yang terlalu panas atau lembap, serta lindungi perangkat dari benturan. Cek kelengkapan isi paket saat barang diterima.',
      ];
      break;
    case 'fashion':
      isi = [
        '$nama dari $brand adalah pakaian dengan potongan yang rapi dan nyaman dipakai seharian. Modelnya mudah dipadukan dengan celana, rok, atau aksesori favoritmu.',
        'Bahannya terasa lembut di kulit, menyerap keringat dengan baik, dan tidak mudah kusut. Cocok untuk kegiatan santai, kuliah, sampai acara yang agak formal.',
        'Perawatan: cuci dengan air dingin, balik pakaian sebelum dicuci agar warna awet, dan hindari pemakaian pemutih. Jemur di tempat teduh, lalu setrika dengan suhu sedang.',
      ];
      break;
    case 'sepatu':
      isi = [
        '$nama dari $brand adalah sepatu dengan desain yang stylish dan nyaman untuk dipakai berjalan sepanjang hari. Modelnya mudah dipadukan dengan pakaian kasual maupun semi-formal.',
        'Bagian sol dibuat cukup empuk dan kuat untuk menopang langkah, sementara bahan atasnya tahan dipakai dalam waktu lama. Pilih ukuran yang sesuai agar kenyamanannya maksimal.',
        'Perawatan: bersihkan dengan sikat lembut dan kain lembap, lalu angin-anginkan di tempat teduh. Hindari menjemur langsung di bawah terik matahari supaya bahan tidak cepat rusak.',
      ];
      break;
    case 'aksesori':
      isi = [
        '$nama dari $brand adalah aksesori fashion yang melengkapi penampilanmu. Desainnya elegan dan tidak berlebihan, jadi enak dipakai untuk kegiatan harian maupun acara tertentu.',
        'Detailnya dikerjakan dengan rapi dan bahan yang dipilih terasa kokoh namun tetap nyaman. Cocok dipakai sendiri, dan bisa juga jadi pilihan hadiah.',
        'Perawatan: lap dengan kain lembut setelah dipakai, simpan di tempat kering, dan hindari kontak langsung dengan parfum, air, atau bahan kimia agar tampilannya tetap awet.',
      ];
      break;
    case 'otomotif':
      isi = [
        '$nama dari $brand adalah produk otomotif yang dirancang untuk performa dan kenyamanan berkendara. Konstruksinya kuat dan siap menemani perjalanan harian maupun perjalanan jauh.',
        'Material yang digunakan dipilih agar tahan terhadap cuaca, getaran, dan pemakaian jangka panjang. Tampilannya sporty dan rapi sehingga cocok untuk kendaraan harian.',
        'Catatan: gunakan sesuai peruntukan dan lakukan pengecekan serta servis berkala di bengkel. Untuk pemasangan, sebaiknya dilakukan oleh mekanik berpengalaman demi keamanan.',
      ];
      break;
    case 'olahraga':
      isi = [
        '$nama dari $brand adalah perlengkapan olahraga yang mendukung aktivitas fisikmu, dari latihan ringan sampai rutin di gym atau lapangan.',
        'Bahannya ringan, kuat, dan nyaman dipakai bergerak. Desainnya dibuat supaya tetap stabil saat dipakai, jadi kamu bisa fokus pada latihan.',
        'Perawatan: bersihkan setelah dipakai, keringkan, dan simpan di tempat yang tidak lembap. Lakukan pemanasan sebelum berolahraga dan gunakan sesuai kemampuan.',
      ];
      break;
    default:
      isi = [
        '$nama dari $brand adalah produk pilihan di UntarianMart dengan kualitas yang terjaga. Dirancang untuk memenuhi kebutuhan harian dengan tampilan yang rapi.',
        'Dibuat dari bahan yang dipilih dengan baik dan dikerjakan dengan teliti, sehingga nyaman dipakai dan tahan untuk jangka panjang.',
        'Gunakan sesuai petunjuk dan simpan di tempat yang bersih dan kering agar kualitasnya tetap terjaga.',
      ];
  }

  return [
    ...isi,
    'Produk dikirim dari $lokasi dan dikemas dengan rapi agar aman sampai tujuan. Kalau masih ada yang ingin ditanyakan soal stok atau varian, langsung saja chat penjual lewat tombol chat di bawah.',
  ];
}