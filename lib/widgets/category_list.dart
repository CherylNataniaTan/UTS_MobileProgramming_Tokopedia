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
                  backgroundColor: Colors.green[100],
                  child: Icon(
                    category['icon'],
                    color: Colors.green[800],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  category['label'],
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}