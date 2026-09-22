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

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(category),
      selected: selected,
      onSelected: (_) {
        onSelected();
      },
    );
  }
}