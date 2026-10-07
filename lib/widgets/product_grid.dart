import 'package:flutter/material.dart';

import '../models/product.dart';
import '../screens/product_detail_screen.dart';

class ProductGrid extends StatefulWidget {
  final List<Product> products;

  const ProductGrid({
    super.key,
    required this.products,
  });

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  final Set<String> favoriteIds = {};

  static const Color primaryRed = Color(0xFFA01626);
  static const Color gray = Color.fromARGB(255, 87, 87, 87);
  static const Color lightGray = Color(0xFFDADAD9);
  static const Color orange = Color(0xFFE89D2D);

  void toggleFavorite(String productId) {
    setState(() {
      if (favoriteIds.contains(productId)) {
        favoriteIds.remove(productId);
      } else {
        favoriteIds.add(productId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: widget.products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {
        final product = widget.products[index];
        final isFavorite = favoriteIds.contains(product.id);

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                  product: product,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: lightGray),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 1.15,
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                      ),
                      if (product.discountPercentage > 0)
                        Positioned(
                          top: 6,
                          right: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: primaryRed,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '-${product.discountPercentage}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: gray,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Rp ${product.discountedPrice.toString().replaceAllMapped(
                                      RegExp(
                                        r'\B(?=(\d{3})+(?!\d))',
                                      ),
                                      (match) => '.',
                                    )}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryRed,
                                    ),
                                  ),
                                  if (product.discountPercentage > 0)
                                    Text(
                                      'Rp ${product.price.toString().replaceAllMapped(
                                        RegExp(
                                          r'\B(?=(\d{3})+(?!\d))',
                                        ),
                                        (match) => '.',
                                      )}',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: gray,
                                        decoration:
                                            TextDecoration.lineThrough,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  toggleFavorite(product.id),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 18,
                                color: primaryRed,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: orange,
                            ),
                            Text(
                              ' ${product.rating}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: gray,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}