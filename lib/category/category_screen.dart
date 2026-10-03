import 'package:flutter/material.dart';
import 'package:tokopedia/models/product.dart';
import 'package:tokopedia/services/product_service.dart';

import '../search/category_filter_chip.dart';
import '../search/search_result_tile.dart';
import 'category_grid_full.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<String> categories = [
    'Semua', 'Elektronik', 'Fashion', 'Makanan', 'Kecantikan',
    'Olahraga', 'Rumah Tangga', 'Buku', 'Mainan',
  ];

  // kategori kamu -> slug kategori DummyJSON
  static const Map<String, List<String>> categoryMap = {
    'Elektronik': ['smartphones', 'laptops', 'tablets', 'mobile-accessories'],
    'Fashion': ['mens-shirts', 'womens-dresses', 'tops', 'mens-shoes', 'womens-shoes'],
    'Makanan': ['groceries'],
    'Kecantikan': ['beauty', 'skin-care', 'fragrances'],
    'Olahraga': ['sports-accessories'],
    'Rumah Tangga': ['furniture', 'home-decoration', 'kitchen-accessories'],
    'Buku': [],
    'Mainan': [],
  };

  String selectedCategory = 'Semua';
  late Future<List<Product>> _futureProducts;

  static const Color primaryRed = Color(0xFFA01626);
  static const Color darkRed = Color(0xFF700D1B);
  static const Color gray = Color(0xFF575757);

  @override
  void initState() {
    super.initState();
    _futureProducts = _load();
  }

  Future<List<Product>> _load() async {
    if (selectedCategory == 'Semua') {
      return ProductService.fetchProducts();
    }
    final slugs = categoryMap[selectedCategory] ?? [];
    final results = await Future.wait(
      slugs.map((s) => ProductService.fetchProducts(category: s)),
    );
    return results.expand((e) => e).toList();
  }

  void _select(String category) {
    setState(() {
      selectedCategory = category;
      _futureProducts = _load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori'),
        backgroundColor: primaryRed,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Kategori',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkRed),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: categories.map((category) {
                return CategoryFilterChip(
                  category: category,
                  selected: selectedCategory == category,
                  onSelected: () => _select(category),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            const Text(
              'Semua Kategori',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkRed),
            ),
            const SizedBox(height: 12),
            CategoryGridFull(
              selectedCategory: selectedCategory,
              onCategorySelected: _select,
            ),
            const SizedBox(height: 24),
            Text(
              selectedCategory == 'Semua' ? 'Semua Produk' : 'Produk $selectedCategory',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkRed),
            ),
            const SizedBox(height: 12),
            FutureBuilder<List<Product>>(
              future: _futureProducts,
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
                final products = snapshot.data ?? [];
                if (products.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Belum ada produk di kategori ini',
                        style: TextStyle(color: gray),
                      ),
                    ),
                  );
                }
                return Column(
                  children: products
                      .map((p) => SearchResultTile(product: p))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}