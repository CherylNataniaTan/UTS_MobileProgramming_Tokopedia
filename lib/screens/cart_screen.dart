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
  List<Product> selectedProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
        backgroundColor: Colors.green, 
      ),
      backgroundColor: Colors.green[200],
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          final product = widget.products[index];
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
                    price: product.price,
                    quantity: 1,
                    onIncrease: () {},
                    onDecrease: () {},
                  ),
                 ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: selectedProducts.isEmpty
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutScreen(
                        products: selectedProducts,
                      ),
                    ),
                  );
                },
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
