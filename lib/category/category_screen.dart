import 'package:flutter/material.dart';
import 'category_grid_full.dart';
import '../search/category_filter_chip.dart';

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

            const CategoryGridFull(),
          ],
        ),
      ),
    );
  }
}