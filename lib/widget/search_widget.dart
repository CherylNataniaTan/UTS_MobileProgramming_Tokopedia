import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController searchController =
      TextEditingController();

  // Daftar kategori yang bisa dicari
  final List<String> categories = [
    'Elektronik',
    'Kecantikan',
    'Makanan',
    'Rumah',
    'Laptop',
    'Gaming',
    'Tas',
    'Sepatu',
  ];

  void searchProduct() {
    String keyword = searchController.text.trim();

    // Jika pencarian kosong
    if (keyword.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Pencarian Kosong',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              'Masukkan produk yang ingin dicari.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Oke',
                  style: TextStyle(
                    color: Color(0xFFA4101E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );

      return;
    }

    // Mengecek apakah keyword ada di daftar kategori
    bool found = categories.any(
      (category) =>
          category.toLowerCase() == keyword.toLowerCase(),
    );

    // Jika kategori tidak ditemukan
    if (!found) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Produk Tidak Ditemukan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              '"$keyword" tidak ditemukan.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Oke',
                  style: TextStyle(
                    color: Color(0xFFA4101E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );

      return;
    }

    // Jika kategori ditemukan
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Produk Ditemukan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Kategori "$keyword" ditemukan.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Oke',
                style: TextStyle(
                  color: Color(0xFFA4101E),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
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
        12,
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

        // Tekan Enter/Search di keyboard
        onSubmitted: (_) {
          searchProduct();
        },

        decoration: const InputDecoration(
          hintText: 'Cari di UntarianMart...',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),

          // Hanya satu icon search di sebelah kiri
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFFA4101E),
            size: 30,
          ),

          border: InputBorder.none,

          contentPadding: EdgeInsets.symmetric(
            vertical: 19,
          ),
        ),
      ),
    );
  }
}