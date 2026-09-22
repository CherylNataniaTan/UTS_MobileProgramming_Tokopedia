import 'package:flutter/material.dart';

class ProductShowcaseWidget extends StatelessWidget {
  const ProductShowcaseWidget({super.key});

  static const List<Map<String, dynamic>> products = [
    {
      'name': 'Smartphone Android',
      'price': 'Rp2.499.000',
      'rating': '4.8',
      'image':
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500',
    },
    {
      'name': 'Headphone Wireless',
      'price': 'Rp349.000',
      'rating': '4.7',
      'image':
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500',
    },
    {
      'name': 'Sneakers Casual',
      'price': 'Rp599.000',
      'rating': '4.9',
      'image':
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500',
    },
    {
      'name': 'Tas Wanita',
      'price': 'Rp279.000',
      'rating': '4.6',
      'image':
          'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=500',
    },
    {
      'name': 'Laptop Gaming',
      'price': 'Rp8.999.000',
      'rating': '4.8',
      'image':
          'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=500',
    },
    {
      'name': 'Jam Tangan',
      'price': 'Rp450.000',
      'rating': '4.7',
      'image':
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        18,
        25,
        18,
        30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Produk Pilihan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),

          const SizedBox(height: 15),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,

            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 16,
              childAspectRatio: 0.68,
            ),

            itemBuilder: (context, index) {
              final product = products[index];

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    // FOTO PRODUK
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(
                        top: Radius.circular(14),
                      ),

                      child: Image.network(
                        product['image'],
                        width: double.infinity,
                        height: 145,
                        fit: BoxFit.cover,

                        errorBuilder:
                            (context, error, stackTrace) {
                          return Container(
                            height: 145,
                            color: const Color(0xFFF9E6E8),
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                color: Color(0xFFA4101E),
                                size: 40,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          // NAMA PRODUK
                          Text(
                            product['name'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,

                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 6),

                          // HARGA
                          Text(
                            product['price'],
                            style: const TextStyle(
                              color: Color(0xFFA4101E),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          // RATING
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 17,
                              ),

                              const SizedBox(width: 3),

                              Text(
                                product['rating'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),

                              const SizedBox(width: 4),

                              const Text(
                                '(Terjual)',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}