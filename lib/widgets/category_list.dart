import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  final List<Map<String, dynamic>> categories = const [
    {'label': 'Elektronik', 'icon': Icons.tv},
    {'label': 'Fashion', 'icon': Icons.checkroom},
    {'label': 'Makanan', 'icon': Icons.fastfood},
    {'label': 'Kecantikan', 'icon': Icons.face},
    {'label': 'Olahraga', 'icon': Icons.sports_soccer},
  ];

  static const Color primaryRed = Color.fromARGB(255, 255, 232, 235);
  static const Color darkRed = Color(0xFF700D1B);
  static const Color lightGray = Color.fromARGB(255, 46, 82, 53);

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
            child: Column(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: lightGray,
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
          );
        },
      ),
    );
  }
}