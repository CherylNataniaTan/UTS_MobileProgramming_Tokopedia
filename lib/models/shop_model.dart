import 'product.dart';

class ShopModel {
  final String id;
  final String name;
  final String location;
  final String description;
  final double rating;

  const ShopModel({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.rating,
  });
}

const List<ShopModel> dummyShops = [
  ShopModel(
    id: 'S1',
    name: 'Untar Official Store',
    location: 'Jakarta Barat',
    description: 'Toko resmi UntarianMart dengan produk pilihan.',
    rating: 4.9,
  ),
  ShopModel(
    id: 'S2',
    name: 'Gadget Corner',
    location: 'Jakarta Pusat',
    description: 'Pusatnya gadget dan aksesoris elektronik.',
    rating: 4.8,
  ),
  ShopModel(
    id: 'S3',
    name: 'Fashion Hub',
    location: 'Tangerang',
    description: 'Fashion pria dan wanita, harga bersahabat.',
    rating: 4.7,
  ),
  ShopModel(
    id: 'S4',
    name: 'Home & Living',
    location: 'Bandung',
    description: 'Perlengkapan rumah dan kebutuhan sehari-hari.',
    rating: 4.6,
  ),
];

ShopModel getShopForProduct(Product product) {
  final number = int.tryParse(product.id) ?? product.id.hashCode.abs();
  return dummyShops[number % dummyShops.length];
}