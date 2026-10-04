import 'package:flutter/material.dart';
import '../models/product.dart';

import '../data/cart_data.dart';
import '../widgets/cart_item_widget.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> selectedProducts = [];

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
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryRed = Color(0xFFA01626);
    const Color darkRed = Color(0xFF700D1B);

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
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: cartProducts.length,
              itemBuilder: (context, index) {
                final product = cartProducts[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: Row(
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
                  ),
                );
              },
            ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.white,
        child: ElevatedButton(
          onPressed:
              selectedProducts.isEmpty ? null : goToCheckout,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryRed,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
          child: const Text(
            'Checkout',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}