import '../models/product.dart';

List<Product> cartProducts = [];

Map<String, int> cartQuantities = {};

void addToCart(Product product, int quantity) {
  if (cartProducts.contains(product)) {
    cartQuantities[product.id] =
        (cartQuantities[product.id] ?? 1) + quantity;
  } else {
    cartProducts.add(product);
    cartQuantities[product.id] = quantity;
  }
}