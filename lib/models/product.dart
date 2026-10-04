class Product {
  final String id;
  final String name;
  final String imageUrl;
  final int price;
  final double rating;
  final String category;
  final int reviewCount;
  final int sold;
  final String sellerName;
  final String sellerLocation;
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.category,
    required this.reviewCount,
    required this.sold,
    required this.sellerName,
    required this.sellerLocation,
    required this.description,
  });

factory Product.fromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'].toString(),
    name: json['title'] ?? '',
    price: ((json['price'] as num) * 16000).toInt(),
    imageUrl: json['thumbnail'] ?? '',
    rating: (json['rating'] as num).toDouble(),
    category: json['category'] ?? '',
    reviewCount: (json['reviews'] as List?)?.length ?? 0,
    sold: (json['stock'] as num?)?.toInt() ?? 0,
    sellerName: json['brand'] ?? 'UntarianMart',
    sellerLocation: 'Jakarta',
    description: json['description'] ?? '',
  );
}
}