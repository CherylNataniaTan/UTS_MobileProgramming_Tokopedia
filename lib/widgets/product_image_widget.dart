import 'package:flutter/material.dart';

class ProductImageWidget extends StatefulWidget {
  final String imageUrl;
  final List<String> images;

  const ProductImageWidget({
    super.key,
    required this.imageUrl,
    this.images = const [],
  });

  @override
  State<ProductImageWidget> createState() => _ProductImageWidgetState();
}

class _ProductImageWidgetState extends State<ProductImageWidget> {
  final PageController _controller = PageController();
  int _current = 0;

  // Pakai foto asli dari API; kalau kosong, pakai thumbnail saja
  List<String> get _images =>
      widget.images.isNotEmpty ? widget.images : [widget.imageUrl];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Widget _arrow(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.black38,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = _images;
    final canSlide = images.length > 1;

    return Container(
      color: Colors.white,
      height: 360,
      width: double.infinity,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                _current = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(
                images[index],
                fit: BoxFit.contain, 
                width: double.infinity,
                height: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
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

          if (canSlide && _current > 0)
            Positioned(
              left: 8,
              top: 0,
              bottom: 0,
              child: Center(
                child: _arrow(Icons.chevron_left, () => _goTo(_current - 1)),
              ),
            ),
          if (canSlide && _current < images.length - 1)
            Positioned(
              right: 8,
              top: 0,
              bottom: 0,
              child: Center(
                child: _arrow(Icons.chevron_right, () => _goTo(_current + 1)),
              ),
            ),

          if (canSlide)
            Positioned(
              right: 12,
              bottom: 12,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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