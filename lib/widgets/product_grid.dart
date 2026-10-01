import 'package:flutter/material.dart';
import 'package:tokopedia/services/product_service.dart';
import '../models/product.dart';
import '../screens/product_detail_screen.dart';
import 'product_cart_widget.dart';
class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key, required List<Product> products});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  late Future<List<Product>> _future;

  @override
  void initState() {
    super.initState();
    _future = ProductService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Text('Gagal memuat produk'));
        }
        final products = snapshot.data!;
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, i) => ProductcartWidget(product: products[i]),
        );
      },
    );
  }
}

  const Color primaryRed = Color(0xFFA01626);
  const Color gray = Color.fromARGB(255, 87, 87, 87);
  const Color lightGray = Color(0xFFDADAD9);
  const Color orange = Color(0xFFE89D2D);

  @override
  Widget build(BuildContext context, dynamic products) {
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

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(product: product),
              ),
            );
          },
          child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: lightGray,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.15,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
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
                        'Rp ${product.price.toString().replaceAllMapped(
                          RegExp(r'\B(?=(\d{3})+(?!\d))'),
                          (match) => '.',
                        )}',
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
          ),
          ),
        );
      },
    );
  }