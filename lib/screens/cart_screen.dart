import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/shop_model.dart';
import '../models/order_model.dart';

import '../data/cart_data.dart';
import '../widgets/cart_item_widget.dart';
import 'checkout_screen.dart';
import 'orders_screen.dart';
import 'shop_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  static const Color primaryRed = Color(0xFFA01626);
  static const Color darkRed = Color(0xFF700D1B);

  List<Product> selectedProducts = [];


  Map<String, List<Product>> get groupedByShop {
    final Map<String, List<Product>> grouped = {};

    for (var product in cartProducts) {
      final shop = getShopForProduct(product);
      grouped.putIfAbsent(shop.id, () => []).add(product);
    }

    return grouped;
  }

  int get totalSelected {
    int total = 0;

    for (var product in selectedProducts) {
      total += product.price * (cartQuantities[product.id] ?? 1);
    }

    return total;
  }

  bool get allSelected =>
      cartProducts.isNotEmpty &&
      selectedProducts.length == cartProducts.length;

  void toggleAll() {
    setState(() {
      if (allSelected) {
        selectedProducts.clear();
      } else {
        selectedProducts = List<Product>.from(cartProducts);
      }
    });
  }

  void toggleShop(List<Product> products) {
    final allInShopSelected =
        products.every((p) => selectedProducts.contains(p));

    setState(() {
      if (allInShopSelected) {
        selectedProducts.removeWhere((p) => products.contains(p));
      } else {
        for (var p in products) {
          if (!selectedProducts.contains(p)) {
            selectedProducts.add(p);
          }
        }
      }
    });
  }

  void increaseQuantity(Product product) {
    setState(() {
      cartQuantities[product.id] =
          (cartQuantities[product.id] ?? 1) + 1;
    });
  }

  void decreaseQuantity(Product product) {
    setState(() {
      if ((cartQuantities[product.id] ?? 1) > 1) {
        cartQuantities[product.id] =
            cartQuantities[product.id]! - 1;
      }
    });
  }

  void deleteProduct(Product product) {
    setState(() {
      cartProducts.remove(product);
      selectedProducts.remove(product);
      cartQuantities.remove(product.id);
    });
  }

  Future<void> goToCheckout() async {
    if (selectedProducts.isEmpty) {
      return;
    }

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutScreen(
          products: List<Product>.from(selectedProducts),
          quantities: Map<String, int>.from(cartQuantities),
        ),
      ),
    );

    if (result == true) {
      setState(() {
        cartProducts.removeWhere(
          (product) => selectedProducts.contains(product),
        );

        for (var product in selectedProducts) {
          cartQuantities.remove(product.id);
        }

        selectedProducts.clear();
      });

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrdersScreen(
            initialStatusFilter: 'Diproses',
            orders: dummyOrders,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Keranjang',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryRed,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF5DDE0),

      body: cartProducts.isEmpty
          ? const Center(
              child: Text(
                'Keranjang kosong',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: darkRed,
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(10),
              children: groupedByShop.entries.map((entry) {
                final shop =
                    dummyShops.firstWhere((s) => s.id == entry.key);
                final products = entry.value;
                final shopAllSelected =
                    products.every((p) => selectedProducts.contains(p));

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header toko
                      Row(
                        children: [
                          Checkbox(
                            value: shopAllSelected,
                            activeColor: primaryRed,
                            onChanged: (_) => toggleShop(products),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ShopScreen(shop: shop),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.storefront,
                                    color: darkRed,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          shop.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          shop.location,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),

                      // Produk di toko ini
                      ...products.map((product) {
                        return Row(
                          children: [
                            Checkbox(
                              value: selectedProducts.contains(product),
                              activeColor: primaryRed,
                              onChanged: (value) {
                                setState(() {
                                  if (value == true) {
                                    selectedProducts.add(product);
                                  } else {
                                    selectedProducts.remove(product);
                                  }
                                });
                              },
                            ),
                            Expanded(
                              child: CartItemWidget(
                                productName: product.name,
                                imageUrl: product.imageUrl,
                                price: product.price,
                                quantity:
                                    cartQuantities[product.id] ?? 1,
                                onIncrease: () {
                                  increaseQuantity(product);
                                },
                                onDecrease: () {
                                  decreaseQuantity(product);
                                },
                                onDelete: () {
                                  deleteProduct(product);
                                },
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                );
              }).toList(),
            ),

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          color: Colors.white,
          child: Row(
            children: [
              Checkbox(
                value: allSelected,
                activeColor: primaryRed,
                onChanged: (_) => toggleAll(),
              ),
              const Text('Semua'),
              const Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    'Rp${formatRupiah(totalSelected)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryRed,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed:
                    selectedProducts.isEmpty ? null : goToCheckout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryRed,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                ),
                child: Text(
                  'Checkout (${selectedProducts.length})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}