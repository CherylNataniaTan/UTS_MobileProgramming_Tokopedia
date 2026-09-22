import 'package:flutter/material.dart';
import '../widgets/cart_item_widget.dart';
import '../widgets/payment_method_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int quantity = 1;
  String selectedMethod = 'Transfer Bank';

  final String productName = 'Sepatu Sneakers Putih';
  final int productPrice = 250000;

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CartItemWidget(
            productName: productName,
            price: productPrice,
            quantity: quantity,
            onIncrease: increaseQuantity,
            onDecrease: decreaseQuantity,
          ),

          const SizedBox(height: 16),

          PaymentMethodWidget(
            selectedMethod: selectedMethod,
            onChanged: (value) {
              setState(() {
                selectedMethod = value;
              });
            },
          ),
        ],
      ),
    );
  }
}