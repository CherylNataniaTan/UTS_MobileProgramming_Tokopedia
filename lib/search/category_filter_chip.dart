import 'package:UTS_MobileProgramming_Tokopedia/widgets/category_list.dart';
import 'package:flutter/material.dart';

class CategoryFilterChip extends StatelessWidget {
  final String category;
  final bool selected;
  final VoidCallback onSelected;

  const CategoryFilterChip({
    super.key,
    required this.category,
    required this.selected,
    required this.onSelected,
  });

  static const Color green = Color(0xFFA01626);
  static const Color gray = Color(0xFF575757);
  static const Color lightGray = Color(0xFFDADAD9);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(category),
      selected: selected,
      onSelected: (_) {
        onSelected();
      },
      selectedColor: CategoryList.darkRed,
      backgroundColor: Colors.white,
      checkmarkColor: Colors.white,
      labelStyle: TextStyle(
        color: selected ? Colors.white : gray,
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
      ),
      side: BorderSide(
        color: selected ? green : lightGray,
      ),
    );
  }
}