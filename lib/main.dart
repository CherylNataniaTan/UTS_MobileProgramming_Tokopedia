import 'package:flutter/material.dart';

import 'models/product.dart';
import 'screens/main_navigation.dart';

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
      title: 'UntarianMart',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        overscroll: false,
      ),
      home: const MainNavigation(),
    );
  }
}

