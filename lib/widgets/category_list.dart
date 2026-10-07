import 'package:flutter/material.dart';
import '../category/category_screen.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  final List<Map<String, dynamic>> categories = const [
    {'label': 'Elektronik', 'icon': Icons.tv},
    {'label': 'Fashion', 'icon': Icons.checkroom},
    {'label': 'Makanan', 'icon': Icons.fastfood},
    {'label': 'Kecantikan', 'icon': Icons.face},
    {'label': 'Olahraga', 'icon': Icons.sports_soccer},
  ];

  static const Color primaryRed = Color(0xFFA01626);
  static const Color darkRed = Color(0xFF700D1B);
  static const Color lightPink = Color(0xFFF8E6E9);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return Padding(
            padding: const EdgeInsets.only(right: 16),
             child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryScreen(
                      initialCategory: category['label'] as String,
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: lightPink,
                    child: Icon(
                      category['icon'],
                      color: primaryRed,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    category['label'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: darkRed,
                    ),
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