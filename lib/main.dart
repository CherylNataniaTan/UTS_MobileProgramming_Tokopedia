import 'package:flutter/material.dart';

import 'category/category_screen.dart';
import 'screens/Profile_Screen.dart';
import 'screens/cart_screen.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/promo_banner.dart';
import 'widgets/category_list.dart';
import 'widgets/product_grid.dart';
import 'models/product.dart';
import 'services/product_service.dart';

// list keranjang global
final List<Product> cartItems = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        overscroll: false,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color primaryRed = Color(0xFFA01626);
  static const Color darkRed = Color(0xFF700D1B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'UntarianMart',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryRed,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(products: cartItems),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.category),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategoryScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchBarWidget(),
            const SizedBox(height: 16),
            const PromoBanner(),
            const SizedBox(height: 16),
            const Text(
              'Kategori',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: darkRed,
              ),
            ),
            const SizedBox(height: 8),
            const CategoryList(),
            const SizedBox(height: 16),
            const Text(
              'Rekomendasi Untukmu',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: darkRed,
              ),
            ),
            const SizedBox(height: 8),
            FutureBuilder<List<Product>>(
              future: ProductService.fetchProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                return ProductGrid(products: snapshot.data ?? []);
              },
            ),
          ],
        ),
      ),
    );
  }
}