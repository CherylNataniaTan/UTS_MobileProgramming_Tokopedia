import 'dart:math';

import 'package:flutter/material.dart';
import '../data/voucher_data.dart';
import '../models/product.dart';
import '../models/shop_model.dart';
import '../models/order_model.dart';
import '../models/voucher_model.dart';
import '../widgets/shipping_address_widget.dart';
import '../widgets/payment_method_widget.dart';
import '../widgets/order_summary_widget.dart';
import '../data/untarpay_data.dart';
import '../widgets/voucher_checkout_widget.dart';

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

  List<VoucherModel> selectedVouchers = [];

  final int shipping = Random().nextInt(20001) + 5000;
  
  bool _processPayment() {
    if (selectedPayment != 'UntarPay') {
      return true;
    }

    int subtotal = 0;

    for (var product in widget.products) {
      final quantity = widget.quantities[product.id] ?? 1;
      subtotal += product.price * quantity;
    }

    final totalPayment = subtotal + shipping;

    if (!UntarPayData.deductBalance(totalPayment)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Saldo UntarPay tidak mencukupi'),
        ),
      );

      return false;
    }

    return true;
  }


  void _createOrders() {
    final Map<String, List<Product>> grouped = {};

    for (var product in widget.products) {
      final shop = getShopForProduct(product);
      grouped.putIfAbsent(shop.id, () => []).add(product);
    }

    final shippingPerShop = shipping ~/ grouped.length;

    grouped.forEach((shopId, products) {
      final shop = dummyShops.firstWhere(
        (s) => s.id == shopId,
      );

      final items = products.map((p) {
        return OrderItem(
          productName: p.name,
          imageUrl: p.imageUrl,
          price: p.discountedPrice,
          quantity: widget.quantities[p.id] ?? 1,
        );
      }).toList();

      int itemsTotal = 0;

      for (var item in items) {
        itemsTotal += item.price * item.quantity;
      }

      final summaryName = products.length == 1
          ? products.first.name
          : '${products.first.name} +${products.length - 1} produk lain';

      dummyOrders.insert(
        0,
        OrderModel(
          id: generateOrderId(),
          productName: summaryName,
          status: 'Diproses',
          shopName: shop.name,
          items: items,
          shipping: shippingPerShop,
          total: itemsTotal + shippingPerShop,
          paymentMethod: selectedPayment,
        ),
      );
    });
  }

  void _showVoucherSelection() {
    List<VoucherModel> tempVouchers = List.from(selectedVouchers);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pilih Voucher',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    ...userVouchers.map(
                      (voucher) {
                        final isSelected =
                            tempVouchers.contains(voucher);

                        return CheckboxListTile(
                          value: isSelected,
                          activeColor: primaryRed,
                          controlAffinity:
                              ListTileControlAffinity.leading,

                          title: Text(
                            '${voucher.code} (${voucher.discount})',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          subtitle: Text(
                            voucher.description,
                          ),

                          onChanged: (value) {
                            setModalState(() {
                              if (value == true) {
                                tempVouchers.add(voucher);
                              } else {
                                tempVouchers.remove(voucher);
                              }
                            });
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedVouchers = tempVouchers;
                          });

                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryRed,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                        ),
                        child: const Text(
                          'Gunakan Voucher',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int subtotal = 0;
    int productDiscount = 0;

    for (var product in widget.products) {
      int quantity = widget.quantities[product.id] ?? 1;

      subtotal += product.price * quantity;

      productDiscount +=
          (product.price - product.discountedPrice) * quantity;
    }

    int shippingDiscount = 0;
    int voucherDiscount = 0;

    for (var voucher in selectedVouchers) {
      if (voucher.code == 'GRATISONGKIR') {
        shippingDiscount = shipping;
      }

      if (voucher.code == 'HEMAT20') {
        int discount =
            ((subtotal - productDiscount) * 20) ~/ 100;

        if (discount > 20000) {
          discount = 20000;
        }

        voucherDiscount += discount;
      }

      if (voucher.code == 'CASHOFF50') {
        int discount =
            ((subtotal - productDiscount) * 50) ~/ 100;

        voucherDiscount += discount;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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

                ...widget.products.map((product) {
                  int quantity = widget.quantities[product.id] ?? 1;
                    int totalProduct =
                        product.discountedPrice * quantity;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Expanded(child: Text('${product.name} x$quantity')),

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
                }),
              ],
            ),
          ),

          const SizedBox(height: 12),

          VoucherCheckoutWidget(
            selectedVoucher: selectedVouchers.isEmpty
                ? null
                : selectedVouchers.first,
            onTap: _showVoucherSelection,
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
            productDiscount: productDiscount,
            shipping: shipping,
            shippingDiscount: shippingDiscount,
            voucherDiscount: voucherDiscount,
          ),

          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: () {
               if (!_processPayment()) {
                  return;
                }

                _createOrders();

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
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
            ),

            child: const Text(
              'Buat Pesanan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
