import 'package:flutter/material.dart';

class QuantityControlWidget extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

const QuantityControlWidget ({
  super.key,
  required this.quantity,
  required this.onIncrease,
  required this.onDecrease,
});

@override
  Widget build(BuildContext context) {
    return Row ( 
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton( 
          onPressed: onDecrease,
          icon: const Icon(Icons.remove),
        ),

        Text( 
          quantity.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        IconButton( 
          onPressed: onIncrease,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}