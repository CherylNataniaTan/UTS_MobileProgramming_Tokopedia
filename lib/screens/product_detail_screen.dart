import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../widgets/product_image_widget.dart';
import '../widgets/product_info_widget.dart';
import '../widgets/rating_widget.dart';
import '../widgets/seller_info_widget.dart';
import '../widgets/product_action_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  void _addToCart(BuildContext context, int quantity) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$quantity item ditambahkan ke keranjang')),
    );
  }

  void _buyNow(BuildContext context, int quantity) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Lanjut ke pembayaran ($quantity item)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. ProductImageWidget
            ProductImageWidget(imageUrl: product.imageUrl),

            // 2. ProductInfoWidget
            ProductInfoWidget(
              name: product.name,
              price: product.price,
              sold: product.sold,
            ),

            // 3. RatingWidget
            RatingWidget(
              rating: product.rating,
              reviewCount: product.reviewCount,
            ),

            const Divider(height: 24),

            // 4. SellerInfoWidget
            SellerInfoWidget(
              sellerName: product.sellerName,
              sellerLocation: product.sellerLocation,
            ),

            const Divider(height: 8),

            // Deskripsi produk (tambahan biar halaman terasa lengkap)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Deskripsi Produk',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 6),
                  Text(product.description),
                ],
              ),
            ),
            const SizedBox(height: 80), // spasi biar gak ketutup tombol bawah
          ],
        ),
      ),
      // 5. ProductActionWidget
      bottomNavigationBar: ProductActionWidget(
        onAddToCart: (qty) => _addToCart(context, qty),
        onBuyNow: (qty) => _buyNow(context, qty),
      ),
    );
  }
}