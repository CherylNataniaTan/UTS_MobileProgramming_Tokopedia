import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/product_service.dart';
import '../widgets/product_grid.dart';

class FlashSaleScreen extends StatefulWidget {
  const FlashSaleScreen({super.key});

  static const Color primaryRed = Color(0xFFA01626);

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

          final flashSaleProducts = snapshot.data!
              .where((product) => product.discountPercentage >= 15)
              .toList();

          if (flashSaleProducts.isEmpty) {
            return const Center(child: Text('Belum ada produk flash sale.'));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ProductGrid(products: flashSaleProducts),
          );
        },
      ),
    );
  }
}