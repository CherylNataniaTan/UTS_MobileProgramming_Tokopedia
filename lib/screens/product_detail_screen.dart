import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_image_widget.dart';
import '../widgets/product_info_widget.dart';
import '../widgets/rating_widget.dart';
import '../widgets/seller_info_widget.dart';
import '../widgets/product_action_widget.dart';



class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  static const Color green = Color(0xFF03AC0E);
  static const Color sectionGray = Color(0xFFF3F4F5);

  int quantity = 1;
  bool descExpanded = false;
  bool showAllReviews = false;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
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

  Widget _infoRow(String label, String value, {bool isGreen = false}) {
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
              color: isGreen ? green : Colors.black87,
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
              Icon(Icons.location_on_outlined,
                  size: 20, color: Colors.grey[700]),
              const SizedBox(width: 8),
              Text('Dikirim dari ${widget.product.sellerLocation}'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.local_shipping_outlined,
                  size: 20, color: Colors.grey[700]),
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
                      color: quantity > 1 ? green : Colors.grey[400],
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
                    child: Icon(Icons.add, size: 20, color: green),
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
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Detail Produk'),
          const SizedBox(height: 8),
          _infoRow('Kondisi', 'Baru'),
          _infoRow('Min. Pemesanan', '1 Buah'),
          _infoRow('Kategori', widget.product.category, isGreen: true),
          const Divider(height: 24),
          Text(
            widget.product.description,
            maxLines: descExpanded ? null : 2,
            overflow:
                descExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: const TextStyle(height: 1.4),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () {
              setState(() {
                descExpanded = !descExpanded;
              });
            },
            child: Text(
              descExpanded ? 'Lihat Lebih Sedikit' : 'Selengkapnya',
              style: const TextStyle(
                color: green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviews() {
  final reviews = widget.product.reviews;
  final shown = showAllReviews ? reviews : reviews.take(2).toList();

  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _sectionTitle('Ulasan Pilihan'),
            if (reviews.length > 2)
              InkWell(
                onTap: () {
                  setState(() {
                    showAllReviews = !showAllReviews;
                  });
                },
                child: Text(
                  showAllReviews ? 'Lihat Sedikit' : 'Lihat Semua',
                  style: const TextStyle(
                      color: green, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (reviews.isEmpty)
          Text(
            'Belum ada ulasan',
            style: TextStyle(color: Colors.grey[600]),
          ),
        for (final review in shown)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    for (int i = 0; i < 5; i++)
                      Icon(
                        Icons.star,
                        size: 14,
                        color: i < review.rating
                            ? Colors.amber
                            : Colors.grey[300],
                      ),
                    const SizedBox(width: 6),
                    Text(
                      review.timeAgo,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  review.reviewerName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(review.comment),
              ],
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
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Foto produk
            ProductImageWidget(imageUrl: product.imageUrl),

            // 2. Harga + nama
            ProductInfoWidget(
              name: product.name,
              price: product.price,
            ),

            // 3. Terjual + rating
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

            // 4. Info toko
            SellerInfoWidget(
              sellerName: product.sellerName,
              sellerLocation: product.sellerLocation,
            ),

            _gap(),
            _buildDetail(),
            _gap(),
            _buildReviews(),
          ],
        ),
      ),
      // 5. Tombol bawah
      bottomNavigationBar: ProductActionWidget(
        onChat: () => _showMessage('Fitur chat belum tersedia'),
        onAddToCart: () =>
            _showMessage('$quantity item ditambahkan ke keranjang'),
        onBuyNow: () => _showMessage('Lanjut ke pembayaran ($quantity item)'),
      ),
    );
  }
}