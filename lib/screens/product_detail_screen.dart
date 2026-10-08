import 'package:flutter/material.dart';

import '../chat/chat_data.dart';
import '../chat/chat_detail_screen.dart';
import '../data/cart_data.dart';
import '../data/product_description.dart';
import '../models/order_model.dart';
import '../models/product.dart';
import '../widgets/product_image_widget.dart';
import '../widgets/product_info_widget.dart';
import '../widgets/rating_widget.dart';
import '../widgets/seller_info_widget.dart';
import '../widgets/product_action_widget.dart';
import '../widgets/product_review_section.dart';
import 'cart_screen.dart';
import 'checkout_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  static const Color primaryRed = Color(0xFFA01626);
  static const Color sectionGray = Color(0xFFF3F4F5);

  int quantity = 1;
  bool descExpanded = false;

  // true kalau ada pesanan produk ini yang statusnya Selesai.
  // CATATAN: 'productName' adalah tebakan nama field di OrderModel,
  // sesuaikan kalau di model kamu namanya beda (misal 'title' / 'name').
  bool get _hasReceived => dummyOrders.any(
        (o) => o.status == 'Selesai' && o.productName == widget.product.name,
      );

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // Buka chat dengan penjual produk ini (nyambung ke menu Chat)
  void _openChat() {
    final sellerName = widget.product.sellerName;

    // dibuat dulu di sini biar langsung muncul di list Chat
    getOrCreateThread(sellerName);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatDetailScreen(
          sellerName: sellerName,
          product: widget.product,
        ),
      ),
    );
  }

  // Pembatas antar bagian (abu-abu tebal kayak di Tokopedia)
  Widget _gap() {
    return Container(height: 8, color: sectionGray);
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget _infoRow(String label, String value, {bool isRed = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: isRed ? primaryRed : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShipping() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Pengiriman'),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 20,
                color: Colors.grey[700],
              ),
              const SizedBox(width: 8),
              Text('Dikirim dari ${widget.product.sellerLocation}'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.local_shipping_outlined,
                size: 20,
                color: Colors.grey[700],
              ),
              const SizedBox(width: 8),
              const Text('Ongkir mulai Rp9.000'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.schedule, size: 20, color: Colors.grey[700]),
              const SizedBox(width: 8),
              const Text('Estimasi tiba 2 - 4 hari'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantity() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _sectionTitle('Atur jumlah'),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      Icons.remove,
                      size: 20,
                      color: quantity > 1 ? primaryRed : Colors.grey[400],
                    ),
                  ),
                ),
                SizedBox(
                  width: 36,
                  child: Text(
                    '$quantity',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.add, size: 20, color: primaryRed),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetail() {
    final paragraphs = buildDescription(widget.product);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Detail Produk'),
          const SizedBox(height: 8),
          _infoRow('Kondisi', 'Baru'),
          _infoRow('Min. Pemesanan', '1 Buah'),
          _infoRow(
            'Kategori',
            categoryLabel(widget.product.category),
            isRed: true,
          ),
          const Divider(height: 24),


          if (descExpanded)
            for (final paragraph in paragraphs) ...[
              Text(paragraph, style: const TextStyle(height: 1.5)),
              const SizedBox(height: 10),
            ]
          else
            Text(
              paragraphs.first,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(height: 1.5),
            ),

          const SizedBox(height: 4),
          InkWell(
            onTap: () {
              setState(() {
                descExpanded = !descExpanded;
              });
            },
            child: Text(
              descExpanded ? 'Lihat Lebih Sedikit' : 'Selengkapnya',
              style: const TextStyle(
                color: primaryRed,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        // Kotak pencarian, cuma tampilan aja
        title: Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.search, size: 20, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                'Cari di UntarianMart',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () => _showMessage('Link produk disalin'),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageWidget(
              imageUrl: product.imageUrl,
              images: product.images,
            ),

            ProductInfoWidget(
              name: product.name,
              price: product.discountedPrice,
              originalPrice: product.price,
              discountPercentage: product.discountPercentage,
            ),

            RatingWidget(
              rating: product.rating,
              reviewCount: product.reviewCount,
              sold: product.sold,
            ),

            _gap(),
            _buildShipping(),
            _gap(),
            _buildQuantity(),
            _gap(),

            SellerInfoWidget(
              sellerName: product.sellerName,
              sellerLocation: product.sellerLocation,
            ),

            _gap(),
            _buildDetail(),
            _gap(),

            ProductReviewSection(
              productId: product.id,
              baseRating: product.rating,
              canReview: _hasReceived,
            ),
          ],
        ),
      ),
      bottomNavigationBar: ProductActionWidget(
        onChat: _openChat,
        onAddToCart: () {
          addToCart(product, quantity);
          _showMessage('$quantity item ditambahkan ke keranjang');
        },
        onBuyNow: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CheckoutScreen(
                products: [product],
                quantities: {product.id: quantity},
              ),
            ),
          );

          if (result == true && mounted) {
            Navigator.pop(context); // balik dari detail produk
          }
        },
      ),
    );
  }
}