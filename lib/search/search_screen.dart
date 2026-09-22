import 'package:flutter/material.dart';

import '../data/dummy_products.dart';
import 'search_result_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  String searchQuery = '';

  static const Color primaryRed = Color(0xFFA01626);
  static const Color darkRed = Color(0xFF700D1B);
  static const Color gray = Color(0xFF575757);
  static const Color lightGray = Color(0xFFDADAD9);

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = dummyProducts.where((product) {
      return product.name.toLowerCase().contains(
            searchQuery.toLowerCase(),
          );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Produk'),
        backgroundColor: primaryRed,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari produk...',
                hintStyle: const TextStyle(
                  color: gray,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: primaryRed,
                ),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: primaryRed,
                        ),
                        onPressed: () {
                          searchController.clear();

                          setState(() {
                            searchQuery = '';
                          });
                        },
                      )
                    : null,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: primaryRed,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: lightGray,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredProducts.isEmpty
                  ? const Center(
                      child: Text(
                        'Produk tidak ditemukan',
                        style: TextStyle(
                          color: darkRed,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        return SearchResultTile(
                          product: filteredProducts[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}