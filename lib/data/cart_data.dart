import '../models/product.dart';

List<Product> cartProducts = [];

Map<String, int> cartQuantities = {};

void addToCart(Product product, int quantity) {
  final exists = cartProducts.any((p) => p.id == product.id);

  if (exists) {
    cartQuantities[product.id] =
        (cartQuantities[product.id] ?? 1) + quantity;
  } else {
    cartProducts.add(product);
    cartQuantities[product.id] = quantity;
  }
}