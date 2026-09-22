import 'package:flutter/material.dart';

import '../data/dummy_products.dart';
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
    'Semua',
    'Elektronik',
    'Fashion',
    'Makanan',
    'Kecantikan',
    'Olahraga',
    'Rumah Tangga',
    'Buku',
    'Mainan',
  ];

  String selectedCategory = 'Semua';

  @override
  Widget build(BuildContext context) {
    final filteredProducts = selectedCategory == 'Semua'
        ? dummyProducts
        : dummyProducts.where((product) {
            return product.category == selectedCategory;
          }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Kategori',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: categories.map((category) {
                return CategoryFilterChip(
                  category: category,
                  selected: selectedCategory == category,
                  onSelected: () {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            const Text(
              'Semua Kategori',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            CategoryGridFull(
              selectedCategory: selectedCategory,
              onCategorySelected: (category) {
                setState(() {
                  selectedCategory = category;
                });
              },
            ),

            const SizedBox(height: 24),

            Text(
              selectedCategory == 'Semua'
                  ? 'Semua Produk'
                  : 'Produk $selectedCategory',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            if (filteredProducts.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Belum ada produk di kategori ini',
                  ),
                ),
              )
            else
              Column(
                children: filteredProducts.map((product) {
                  return SearchResultTile(
                    product: product,
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}