import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart'; // sesuaikan path & nama file model lo

class ProductService {
  static Future<Product> fetchProduct(int id) async {
    final res = await http.get(Uri.parse('https://dummyjson.com/products/$id'));
    if (res.statusCode == 200) {
      return Product.fromJson(jsonDecode(res.body));
    }
    throw Exception('Gagal load produk');
  }
}