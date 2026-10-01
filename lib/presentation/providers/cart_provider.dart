
import 'package:flutter/foundation.dart';

import '../../domain/entities/product.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, int> _cartItems = {};

  // ----------------------------------------------------------
  // GET CART ITEMS
  // ----------------------------------------------------------

  Map<String, int> get cartItems =>
      Map.unmodifiable(_cartItems);

  // ----------------------------------------------------------
  // CART COUNT
  // ----------------------------------------------------------

  int get cartCount {
    return _cartItems.values.fold(
      0,
      (total, quantity) => total + quantity,
    );
  }

  // ----------------------------------------------------------
  // CHECK PRODUCT
  // ----------------------------------------------------------

  bool isInCart(String productId) {
    return _cartItems.containsKey(productId);
  }

  // ----------------------------------------------------------
  // GET QUANTITY
  // ----------------------------------------------------------

  int getQuantity(String productId) {
    return _cartItems[productId] ?? 0;
  }

  // ----------------------------------------------------------
  // ADD TO CART
  // ----------------------------------------------------------

  void addToCart(Product product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems[product.id] =
          _cartItems[product.id]! + 1;
    } else {
      _cartItems[product.id] = 1;
    }

    notifyListeners();
  }

  // ----------------------------------------------------------
  // REMOVE ONE
  // ----------------------------------------------------------

  void removeOne(String productId) {
    final quantity =
        _cartItems[productId] ?? 0;

    if (quantity <= 1) {
      _cartItems.remove(productId);
    } else {
      _cartItems[productId] =
          quantity - 1;
    }

    notifyListeners();
  }

  // ----------------------------------------------------------
  // REMOVE COMPLETELY
  // ----------------------------------------------------------

  void removeFromCart(String productId) {
    _cartItems.remove(productId);

    notifyListeners();
  }

  // ----------------------------------------------------------
  // CLEAR CART
  // ----------------------------------------------------------

  void clearCart() {
    _cartItems.clear();

    notifyListeners();
  }

  // ----------------------------------------------------------
  // TOTAL PRICE
  // ----------------------------------------------------------

  double totalPrice(
    List<Product> products,
  ) {
    double total = 0;

    for (final product in products) {
      final quantity =
          _cartItems[product.id] ?? 0;

      total += product.price * quantity;
    }

    return total;
  }
}

