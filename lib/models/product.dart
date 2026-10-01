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
    final reviews = (json['reviews'] as List?) ?? [];
    return Product(
      id: json['id'].toString(),
      name: json['title'] ?? '',
      // DummyJSON harganya USD, dikali 16000 biar kayak rupiah
      price: (((json['price'] ?? 0) as num) * 16000).round(),
      imageUrl: json['thumbnail'] ?? '',
      rating: ((json['rating'] ?? 0) as num).toDouble(),
      category: json['category'] ?? '',
      reviewCount: reviews.length,
      sold: ((json['stock'] ?? 0) as num).toInt(),
      sellerName: json['brand'] ?? 'Toko Official',
      sellerLocation: 'Jakarta',
      description: json['description'] ?? '',
    );
  }
}