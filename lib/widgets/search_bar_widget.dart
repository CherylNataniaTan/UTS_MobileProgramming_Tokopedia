import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  static const Color primaryRed = Color(0xFFA01626);
  static const Color gray = Color(0xFF575757);
  static const Color lightGray = Color(0xFFDADAD9);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: lightGray,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: primaryRed,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Cari barang...',
                hintStyle: TextStyle(
                  color: gray,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}