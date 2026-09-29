import 'package:flutter/material.dart';

class ProductActionWidget extends StatefulWidget {
  final Function(int quantity) onAddToCart;
  final Function(int quantity) onBuyNow;

  const ProductActionWidget({
    super.key,
    required this.onAddToCart,
    required this.onBuyNow,
  });

  @override
  State<ProductActionWidget> createState() => _ProductActionWidgetState();
}

class _ProductActionWidgetState extends State<ProductActionWidget> {
  int quantity = 1;

  void _increment() {
    setState(() {
      quantity++;
    });
  }

  void _decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pilih jumlah barang
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Jumlah',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: _decrement,
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Text(
                    '$quantity',
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    onPressed: _increment,
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Tombol Tambah ke Keranjang dan Beli Sekarang
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => widget.onAddToCart(quantity),
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Tambah Keranjang'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => widget.onBuyNow(quantity),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Beli Sekarang',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}