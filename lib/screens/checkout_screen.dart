import 'package:flutter/material.dart';
import 'package:tokopedia/models/product.dart';
import '../widgets/shipping_address_widget.dart';
import '../widgets/payment_method_widget.dart';
import '../widgets/order_summary_widget.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Product> products;

  const CheckoutScreen({
    super.key,
    required this.products,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPayment = 'Transfer Bank';

  @override
  Widget build(BuildContext context) {
    int subtotal = 0;
    for (var product in widget.products) {
      subtotal += product.price;
    }

    int shipping = 10000;
    int discount = 0;

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

                ...widget.products.map( 
                  (product) => Padding( 
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(product.name),
                        ),
                        Text(
                          'Rp${product.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
              ); // Handle checkout logic here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: const Text(
              'Bayar Sekarang',
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