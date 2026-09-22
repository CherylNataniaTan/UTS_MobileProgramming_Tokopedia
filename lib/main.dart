import 'package:flutter/material.dart';

import 'search/search_screen.dart';
import 'category/category_screen.dart';

import 'widgets/search_bar_widget.dart';
import 'widgets/promo_banner.dart';
import 'widgets/category_list.dart';
import 'widgets/product_grid.dart';

import 'data/dummy_products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color primaryRed = Color(0xFFA01626);
  static const Color darkRed = Color(0xFF700D1B);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Marketplace',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: primaryRed,
              foregroundColor: Colors.white,
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
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
              ],
            ),
            body: SingleChildScrollView(
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

                  ProductGrid(
                    products: dummyProducts,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}