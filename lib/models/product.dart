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
  final int discountPercentage;

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
     this.discountPercentage = 0,
  });
}
