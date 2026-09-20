import 'package:flutter/material.dart';
import 'quantity_control_widget.dart';

class CartItemWidget extends StatelessWidget {
  final String productName;
  final int price;
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

   const CartItemWidget({
    super.key,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

 @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: true,
          onChanged: (value) {},
        ),
      Container(
          width: 90,
          height: 90,
          color: Colors.grey[200],
          child: const Icon(
            Icons.shopping_bag,
            size: 40,
          ),
        ),

      const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 8),

              Text(
                'Rp$price',
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),

              QuantityControlWidget(
                quantity: quantity,
                onIncrease: onIncrease,
                onDecrease: onDecrease,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
