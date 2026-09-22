import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  static const List<Map<String, dynamic>> categories = [
    {
      'icon': Icons.phone_android,
      'name': 'Elektronik',
    },
    {
      'icon': Icons.face,
      'name': 'Kecantikan',
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

  void categoryClicked(
    BuildContext context,
    String categoryName,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Kamu memilih kategori $categoryName',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kategori',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),

          const SizedBox(height: 20),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,

            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
              childAspectRatio: 0.72,
            ),

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

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9E6E8),
                        borderRadius:
                            BorderRadius.circular(14),
                      ),

                      child: Icon(
                        category['icon'],
                        color: const Color(0xFFA4101E),
                        size: 30,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      category['name'],
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}