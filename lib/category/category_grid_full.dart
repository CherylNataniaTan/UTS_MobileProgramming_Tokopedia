import 'package:flutter/material.dart';

class CategoryGridFull extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryGridFull({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  static const Color primaryRed = Color(0xFFA01626);
  static const Color darkRed = Color(0xFF700D1B);

  static const List<Map<String, Object>> categories = [
    {'label': 'Elektronik', 'icon': Icons.tv},
    {'label': 'Fashion', 'icon': Icons.checkroom},
    {'label': 'Makanan', 'icon': Icons.fastfood},
    {'label': 'Kecantikan', 'icon': Icons.face},
    {'label': 'Olahraga', 'icon': Icons.sports_soccer},
    {'label': 'Rumah Tangga', 'icon': Icons.home},
    {'label': 'Buku', 'icon': Icons.book},
    {'label': 'Mainan', 'icon': Icons.toys},
  ];

  @override
  Widget build(BuildContext context) {
    final displayedCategories = selectedCategory == 'Semua'
        ? categories
        : categories.where((category) {
            return category['label'] == selectedCategory;
          }).toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: displayedCategories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        final category = displayedCategories[index];

        final String label = category['label'] as String;
        final IconData icon = category['icon'] as IconData;

        final bool isSelected = selectedCategory == label;

        return Card(
          elevation: 2,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              onCategorySelected(label);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 35,
                  color: primaryRed,
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? primaryRed : darkRed,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}