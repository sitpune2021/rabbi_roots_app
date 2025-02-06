import 'package:flutter/material.dart';
import 'package:rabbi_roots/widgets/product_card_sub.dart';

class CartItem {
  final ProductCard product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartModel with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addProduct(ProductCard product) {
    final index = _items
        .indexWhere((item) => item.product.productName == product.productName);
    if (index != -1) {
      // Product already in cart, increase quantity
      _items[index].quantity++;
    } else {
      // Add new product to cart
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeProduct(ProductCard product) {
    _items
        .removeWhere((item) => item.product.productName == product.productName);
    notifyListeners();
  }

  void incrementQuantity(ProductCard product) {
    final index = _items
        .indexWhere((item) => item.product.productName == product.productName);
    if (index != -1) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(ProductCard product) {
    final index = _items
        .indexWhere((item) => item.product.productName == product.productName);
    if (index != -1 && _items[index].quantity > 1) {
      _items[index].quantity--;
      notifyListeners();
    } else {
      removeProduct(product);
    }
  }

  void updateQuantity(ProductCard product, int quantity) {
    final index = _items
        .indexWhere((item) => item.product.productName == product.productName);
    if (index != -1) {
      _items[index].quantity = quantity;
      notifyListeners();
    }
  }

  int getQuantity(ProductCard product) {
    final index = _items
        .indexWhere((item) => item.product.productName == product.productName);
    if (index != -1) {
      return _items[index].quantity;
    }
    return 0;
  }
}
