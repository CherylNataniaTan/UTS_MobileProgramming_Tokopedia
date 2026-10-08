import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/product_service.dart';
import '../widgets/product_grid.dart';

class FlashSaleScreen extends StatefulWidget {
  const FlashSaleScreen({super.key});

  static const Color primaryRed = Color(0xFFA01626);

  // produk dianggap flash sale kalau diskonnya segini atau lebih
  static const double minDiscount = 15;

  @override
  State<FlashSaleScreen> createState() => _FlashSaleScreenState();
}

class _FlashSaleScreenState extends State<FlashSaleScreen> {
  late Future<List<Product>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = ProductService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flash Sale',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: FlashSaleScreen.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Product>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // ambil yang diskonnya cukup besar, urut dari diskon terbesar
          final flashSaleProducts = snapshot.data!
              .where(
                (product) =>
                    product.discountPercentage >= FlashSaleScreen.minDiscount,
              )
              .toList()
            ..sort(
              (a, b) => b.discountPercentage.compareTo(a.discountPercentage),
            );

          if (flashSaleProducts.isEmpty) {
            return const Center(child: Text('Belum ada produk flash sale.'));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${flashSaleProducts.length} produk lagi diskon',
                  style: TextStyle(color: Colors.grey[700], fontSize: 13),
                ),
                const SizedBox(height: 12),
                Expanded(child: ProductGrid(products: flashSaleProducts)),
              ],
            ),
          );
        },
      ),
    );
  }
}