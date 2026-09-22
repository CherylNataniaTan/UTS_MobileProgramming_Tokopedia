import 'package:flutter/material.dart';

import '../widgets/shipping_address_widget.dart';
import '../widgets/payment_method_widget.dart';
import '../widgets/order_summary_widget.dart';

class CheckoutScreen extends StatefulWidget {
  final String productName;
  final int productPrice;
  final int quantity;

  const CheckoutScreen({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.quantity,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedMethod = 'Transfer Bank';

  @override
  Widget build(BuildContext context) {
    int subtotal = widget.productPrice * widget.quantity;
    int shipping = 10000;
    int discount = 5000;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.green,
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
                  'Produk',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.shopping_bag,
                        size: 35,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.productName),
                          const SizedBox(height: 5),
                          Text(
                            'Rp${widget.productPrice}',
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Jumlah: ${widget.quantity}',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(15),
            color: Colors.white,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pengiriman',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text('Reguler'),
                SizedBox(height: 5),
                Text(
                  'Rp10000',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          PaymentMethodWidget(
            selectedMethod: selectedMethod,
            onChanged: (value) {
              setState(() {
                selectedMethod = value;
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
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: const Text(
              'Buat Pesanan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}