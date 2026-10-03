import 'review.dart';

class Product {
  final String id;
  final String name;
  final int price;
  final String imageUrl;
  final double rating;
  final String category;
  final int reviewCount;
  final int sold;
  final String sellerName;
  final String sellerLocation;
  final String description;
  final List<Review> reviews;
  final double discountPercentage;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.category,
    required this.reviewCount,
    required this.sold,
    required this.sellerName,
    required this.sellerLocation,
    required this.description,
    this.reviews = const [],
    this.discountPercentage = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final reviewList = (json['reviews'] as List? ?? [])
        .map((e) => Review.fromJson(e))
        .toList();

    return Product(
      id: json['id'].toString(),
      name: json['title'] ?? '',
      price: ((json['price'] as num) * 16000).toInt(),
      imageUrl: json['thumbnail'] ?? '',
      rating: (json['rating'] as num).toDouble(),
      category: json['category'] ?? '',
      reviewCount: reviewList.length,
      sold: (json['stock'] as num?)?.toInt() ?? 0,
      sellerName: json['brand'] ?? 'UntarianMart',
      sellerLocation: 'Jakarta',
      description: json['description'] ?? '',
      reviews: reviewList,
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0,
    );
  }

  int get discountedPrice =>
  (price * (1- discountPercentage / 100)).round();
    
}