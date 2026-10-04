import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const String _baseUrl = 'https://dummyjson.com';

  // Satu produk
  static Future<Product> fetchProduct(int id) async {
    final res = await http.get(Uri.parse('$_baseUrl/products/$id'));
    if (res.statusCode == 200) {
      return Product.fromJson(jsonDecode(res.body));
    }
    throw Exception('Gagal load produk');
  }

  // Semua produk (194 item)
  static Future<List<Product>> fetchProducts({String? category}) async {
    final url = category == null
        ? '$_baseUrl/products?limit=0'
        : '$_baseUrl/products/category/$category?limit=0';

    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body)['products'];
      return data.map((e) => Product.fromJson(e)).toList();
    }
    throw Exception('Gagal load daftar produk');
  }

  // Cari produk
  static Future<List<Product>> searchProducts(String query) async {
    final res = await http.get(Uri.parse('$_baseUrl/products/search?q=$query'));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body)['products'];
      return data.map((e) => Product.fromJson(e)).toList();
    }
    throw Exception('Gagal mencari produk');
  }
}