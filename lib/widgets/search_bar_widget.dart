import 'package:flutter/material.dart';
import '../search/search_screen.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  static const Color primaryRed = Color(0xFFA01626);
  static const Color gray = Color(0xFF575757);
  static const Color lightGray = Color(0xFFDADAD9);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SearchScreen(),
          ),
        );
      },
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: lightGray,
          ),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.search,
              color: primaryRed,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Cari barang...',
                style: TextStyle(
                  color: gray,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}