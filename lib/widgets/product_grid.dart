import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;

  const ProductGrid({super.key, required this.products});

  static const Color primaryRed = Color(0xFFA01626);
  static const Color darkRed = Color(0xFF700D1B);
  static const Color gray = Color.fromARGB(255, 87, 87, 87);
  static const Color lightGray = Color(0xFFDADAD9);
  static const Color orange = Color(0xFFE89D2D);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: lightGray,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
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
                    Text(
                      'Rp${product.price}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryRed,
                      ),
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
        );
      },
    );
  }
}