import 'package:flutter/material.dart';

class CategoryGridFull extends StatelessWidget {
  const CategoryGridFull({super.key});

  final List<Map<String, dynamic>> categories = const [
    {
      'label': 'Elektronik',
      'icon': Icons.tv,
    },
    {
      'label': 'Fashion',
      'icon': Icons.checkroom,
    },
    {
      'label': 'Makanan',
      'icon': Icons.fastfood,
    },
    {
      'label': 'Kecantikan',
      'icon': Icons.face,
    },
    {
      'label': 'Olahraga',
      'icon': Icons.sports_soccer,
    },
    {
      'label': 'Rumah Tangga',
      'icon': Icons.home,
    },
    {
      'label': 'Buku',
      'icon': Icons.book,
    },
    {
      'label': 'Mainan',
      'icon': Icons.toys,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];

        return Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                category['icon'],
                size: 35,
                color: Colors.green,
              ),
              const SizedBox(height: 8),
              Text(
                category['label'],
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}