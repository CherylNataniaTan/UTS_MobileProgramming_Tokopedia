import '../models/product_model.dart';

// Data dummy produk buat ditampilin di home page
final List<ProductModel> dummyProducts = [
  ProductModel(
    id: '1',
    name: 'Kaos Polos Cotton Combed 30s',
    price: 65000,
    imageUrl: 'https://picsum.photos/seed/kaos/400/400',
    rating: 4.8,
    reviewCount: 1240,
    sold: 3200,
    sellerName: 'Clothing Store Official',
    sellerLocation: 'Bandung',
    description:
        'Kaos polos bahan cotton combed 30s, adem dan gak gampang melar. '
        'Cocok buat dipake sehari-hari atau bahan sablon custom.',
  ),
  ProductModel(
    id: '2',
    name: 'Sepatu Sneakers Casual Pria',
    price: 189000,
    imageUrl: 'https://picsum.photos/seed/sepatu/400/400',
    rating: 4.6,
    reviewCount: 856,
    sold: 1500,
    sellerName: 'Footwear Hub',
    sellerLocation: 'Jakarta Barat',
    description:
        'Sepatu sneakers casual, ringan dan nyaman dipakai seharian. '
        'Tersedia berbagai ukuran, bahan berkualitas dan tahan lama.',
  ),
  ProductModel(
    id: '3',
    name: 'Tas Ransel Laptop Anti Air',
    price: 145000,
    imageUrl: 'https://picsum.photos/seed/tas/400/400',
    rating: 4.7,
    reviewCount: 632,
    sold: 980,
    sellerName: 'Bagpack Store',
    sellerLocation: 'Surabaya',
    description:
        'Tas ransel muat laptop hingga 15 inch, bahan waterproof, '
        'banyak kompartemen buat nyimpen barang bawaan.',
  ),
  ProductModel(
    id: '4',
    name: 'Smartwatch Fitness Tracker',
    price: 249000,
    imageUrl: 'https://picsum.photos/seed/smartwatch/400/400',
    rating: 4.5,
    reviewCount: 410,
    sold: 720,
    sellerName: 'Gadget Center',
    sellerLocation: 'Tangerang',
    description:
        'Smartwatch dengan fitur pengukur detak jantung, penghitung langkah, '
        'dan notifikasi HP. Baterai tahan hingga 7 hari.',
  ),
  ProductModel(
    id: '5',
    name: 'Botol Minum Stainless Steel 1L',
    price: 55000,
    imageUrl: 'https://picsum.photos/seed/botol/400/400',
    rating: 4.9,
    reviewCount: 990,
    sold: 2100,
    sellerName: 'Daily Living Store',
    sellerLocation: 'Bekasi',
    description:
        'Botol minum stainless steel kapasitas 1 liter, tetap dingin hingga '
        '12 jam. Bebas BPA dan aman buat kesehatan.',
  ),
  ProductModel(
    id: '6',
    name: 'Headset Bluetooth TWS',
    price: 99000,
    imageUrl: 'https://picsum.photos/seed/headset/400/400',
    rating: 4.4,
    reviewCount: 350,
    sold: 640,
    sellerName: 'Audio World',
    sellerLocation: 'Jakarta Selatan',
    description:
        'Headset bluetooth true wireless, suara jernih, dilengkapi charging '
        'case. Cocok buat nelepon maupun dengerin musik.',
  ),
];