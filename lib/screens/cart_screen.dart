import 'package:flutter/material.dart';
import 'package:tokopedia/models/product.dart';

import '../widgets/cart_item_widget.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  final List<Product> products;

  const CartScreen({
    super.key,
    required this.products,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<Product> cartProducts;

  List<Product> selectedProducts = [];

  Map<String, int> quantities = {};

  @override
  void initState() {
    super.initState();

    cartProducts = List<Product>.from(widget.products);

    for (var product in cartProducts) {
      quantities[product.id] = 1;
    }
  }

  void increaseQuantity(Product product) {
    setState(() {
      quantities[product.id] = quantities[product.id]! + 1;
    });
  }

  void decreaseQuantity(Product product) {
    setState(() {
      if (quantities[product.id]! > 1) {
        quantities[product.id] = quantities[product.id]! - 1;
      }
    });
  }

  void deleteProduct(Product product) {
    setState(() {
      cartProducts.remove(product);
      selectedProducts.remove(product);
      quantities.remove(product.id);
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
          products: selectedProducts,
          quantities: quantities,
        ),
      ),
    );

    if (result == true) {
      setState(() {
        cartProducts.removeWhere(
          (product) => selectedProducts.contains(product),
        );

        for (var product in selectedProducts) {
          quantities.remove(product.id);
        }

        selectedProducts.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
        backgroundColor: Colors.green,
      ),

      backgroundColor: Colors.green[200],

      body: cartProducts.isEmpty
          ? const Center(
              child: Text(
                'Keranjang kosong',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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
                          quantity: quantities[product.id]!,
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
          onPressed: selectedProducts.isEmpty
              ? null
              : goToCheckout,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
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