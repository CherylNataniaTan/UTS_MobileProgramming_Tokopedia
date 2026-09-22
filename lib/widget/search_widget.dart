import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController searchController =
      TextEditingController();

  void searchProduct() {
    String keyword = searchController.text.trim();

    if (keyword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Masukkan produk yang ingin dicari',
          ),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Mencari: $keyword'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        18,
        18,
        18,
        20,
      ),
      height: 62,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: TextField(
        controller: searchController,
        textInputAction: TextInputAction.search,

        onSubmitted: (_) {
          searchProduct();
        },

        decoration: InputDecoration(
          hintText: 'Cari di UntarianMart...',

          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),

          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFFA4101E),
            size: 30,
          ),

          suffixIcon: IconButton(
            onPressed: searchProduct,
            icon: const Icon(
              Icons.search,
              color: Color(0xFFA4101E),
              size: 30,
            ),
          ),

          border: InputBorder.none,

          contentPadding:
              const EdgeInsets.symmetric(
            vertical: 19,
          ),
        ),
      ),
    );
  }
}