import 'package:flutter/material.dart';

class ProductImageWidget extends StatelessWidget {
  final String imageUrl;

  const ProductImageWidget({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      color: Colors.grey[200],
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        // Kalau gambar masih loading
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        // Kalau gambar gagal dimuat
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(
              Icons.image_not_supported,
              size: 60,
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }
}