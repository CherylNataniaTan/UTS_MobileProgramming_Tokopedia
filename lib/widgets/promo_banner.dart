import 'package:flutter/material.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green[400],
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: const Text(
        'Promo Spesial Hari Ini!',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}