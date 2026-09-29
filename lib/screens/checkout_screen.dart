import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tokopedia/models/product.dart';
import '../widgets/shipping_address_widget.dart';
import '../widgets/payment_method_widget.dart';
import '../widgets/order_summary_widget.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Product> products;
  final Map<String, int> quantities;

  const CheckoutScreen({
    super.key,
    required this.products,
    required this.quantities,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  static const Color primaryRed = Color(0xFFA01626);
  static const Color darkRed = Color(0xFF700D1B);

  String selectedPayment = 'COD';

  final int shipping = Random().nextInt(20001) + 5000;

  @override
  Widget build(BuildContext context) {
    int subtotal = 0;

    for (var product in widget.products) {
      int quantity = widget.quantities[product.id] ?? 1;

      subtotal += product.price * quantity;
    }

    int discount = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryRed,
        foregroundColor: Colors.white,
      ),

      backgroundColor: Colors.grey[200],

      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const ShippingAddressWidget(),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(15),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Produk yang Dibeli',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: darkRed,
                  ),
                ),

                const SizedBox(height: 10),

                ...widget.products.map(
                  (product) {
                    int quantity =
                        widget.quantities[product.id] ?? 1;

                    int totalProduct =
                        product.price * quantity;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${product.name} x$quantity',
                            ),
                          ),

                          Text(
                            'Rp$totalProduct',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryRed,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          PaymentMethodWidget(
            selectedMethod: selectedPayment,
            onChanged: (value) {
              setState(() {
                selectedPayment = value;
              });
            },
          ),

          const SizedBox(height: 12),

          OrderSummaryWidget(
            subtotal: subtotal,
            shipping: shipping,
            discount: discount,
          ),

          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pesanan berhasil dibuat'),
                ),
              );

              Navigator.pop(context, true);
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: primaryRed,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),

            child: const Text(
              'Buat Pesanan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}