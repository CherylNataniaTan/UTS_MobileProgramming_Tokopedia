import 'package:flutter/material.dart';

import 'widget/category_widget.dart';
import 'widget/search_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UntarianMart',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFA4101E),
        ),
        useMaterial3: true,
      ),

      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),

      appBar: AppBar(
        backgroundColor: const Color(0xFFA4101E),
        elevation: 0,
        automaticallyImplyLeading: false,

        title: Row(
          children: [
            // LOGO ASLI + KOTAK PUTIH KECIL
            Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Transform.scale(
                  scale: 2.0,
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            const Text(
              'UntarianMart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Spacer(),

            const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
              size: 28,
            ),
          ],
        ),
      ),

      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchWidget(),
            CategoryWidget(),
          ],
        ),
      ),
    );
  }
}