import 'package:flutter/material.dart';

class ProductImageWidget extends StatefulWidget {
  final String imageUrl;

  const ProductImageWidget({
    super.key,
    required this.imageUrl,
  });

  @override
  State<ProductImageWidget> createState() => _ProductImageWidgetState();
}

class _ProductImageWidgetState extends State<ProductImageWidget> {
  int _current = 0;

  // Foto tambahan cuma dummy, seed-nya diganti biar gambarnya beda-beda
  List<String> get _images => [
        widget.imageUrl,
        widget.imageUrl.replaceFirst('/seed/', '/seed/b'),
        widget.imageUrl.replaceFirst('/seed/', '/seed/c'),
        widget.imageUrl.replaceFirst('/seed/', '/seed/d'),
      ];

  @override
  Widget build(BuildContext context) {
    final images = _images;

    return SizedBox(
      height: 360,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                _current = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(
                images[index],
                fit: BoxFit.cover,
                width: double.infinity,
                // Kalau gambar masih loading
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
                // Kalau gambar gagal dimuat
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 60,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          // Penanda halaman foto, contoh "1/4"
          Positioned(
            right: 12,
            bottom: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${_current + 1}/${images.length}',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}