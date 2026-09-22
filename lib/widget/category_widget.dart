import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  static const List<Map<String, dynamic>> categories = [
    {
      'icon': Icons.checkroom,
      'name': 'Fashion',
    },
    {
      'icon': Icons.phone_android,
      'name': 'Elektronik',
    },
    {
      'icon': Icons.face,
      'name': 'Beauty',
    },
    {
      'icon': Icons.fastfood,
      'name': 'Makanan',
    },
    {
      'icon': Icons.home_outlined,
      'name': 'Rumah',
    },
    {
      'icon': Icons.laptop_mac,
      'name': 'Laptop',
    },
    {
      'icon': Icons.sports_esports_outlined,
      'name': 'Gaming',
    },
    {
      'icon': Icons.shopping_bag_outlined,
      'name': 'Tas',
    },
    {
      'icon': Icons.directions_run,
      'name': 'Sepatu',
    },
    {
      'icon': Icons.more_horiz,
      'name': 'Lainnya',
    },
  ];

  void categoryClicked(BuildContext context, String categoryName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Kamu memilih kategori $categoryName'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kategori',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];

                return InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    categoryClicked(
                      context,
                      category['name'],
                    );
                  },
                  child: Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            // Merah muda sebagai background icon
                            color: const Color(0xFFF9E6E8),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            category['icon'],
                            // Merah sesuai logo
                            color: const Color(0xFFA4101E),
                            size: 28,
                          ),
                        ),

                        const SizedBox(height: 7),

                        Text(
                          category['name'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}