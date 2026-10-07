import 'package:flutter/material.dart';

import '../widgets/search_bar_widget.dart';
import '../widgets/promo_banner.dart';
import '../widgets/category_list.dart';
import '../widgets/product_grid.dart';

import '../chat/chat_screen.dart'; 
import 'cart_screen.dart';
import 'notification_screen.dart';

import '../models/product.dart';
import '../services/product_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const Color primaryRed = Color(0xFFA01626);
  static const Color darkRed = Color(0xFF700D1B);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> _futureProducts;

  final ScrollController _scrollController = ScrollController();   // ❌ INI HILANG
  bool _showScrollToTop = false;  

  @override
  void initState() {
    super.initState();
    _futureProducts = ProductService.fetchProducts();

     _scrollController.addListener(() {
      final shouldShow = _scrollController.offset > 300;
      if (shouldShow != _showScrollToTop) {
        setState(() {
          _showScrollToTop = shouldShow;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
 
  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: _showScrollToTop
          ? FloatingActionButton(
              backgroundColor: HomeScreen.primaryRed,
              onPressed: scrollToTop,
              child: const Icon(Icons.arrow_upward, color: Colors.white),
            )
          : null,
      body: Column(
        children: [
          // Header compact: judul sama icon chat, search bar nempel di bawahnya
          Container(
            color: HomeScreen.primaryRed,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Row(
                  children: [
                     const Expanded(
                      child: SearchBarWidget(),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationScreen(),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChatScreen(),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
 
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PromoBanner(),
                  const SizedBox(height: 16),
                  const Text(
                    'Kategori',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: HomeScreen.darkRed,
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
                      color: HomeScreen.darkRed,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FutureBuilder<List<Product>>(
                    future: _futureProducts,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.all(32),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      return ProductGrid(products: snapshot.data!);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}