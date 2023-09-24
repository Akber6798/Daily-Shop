// ignore_for_file: prefer_final_fields

import 'package:daily_shop/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartController with ChangeNotifier {
  Map<String, CartModel> _cartProductItems = {};

  //* for get cart items
  Map<String, CartModel> get getCartProductItems {
    return _cartProductItems;
  }

  //* add products to cart
  void addProductToCart({required String productId, required int quantity}) {
    _cartProductItems.putIfAbsent(
      productId,
      () => CartModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        productId: productId,
        quantity: quantity,
      ),
    );
    notifyListeners();
  }

  //* to reduce quantity by one
  void reduceQuantityByOne(String productId) {
    _cartProductItems.update(
      productId,
      (value) => CartModel(
        id: value.id,
        productId: productId,
        quantity: value.quantity - 1,
      ),
    );
    notifyListeners();
  }

  //* to increase quantity by one
  void increaseQuantityByOne(String productId) {
    _cartProductItems.update(
      productId,
      (value) => CartModel(
        id: value.id,
        productId: productId,
        quantity: value.quantity + 1,
      ),
    );
    notifyListeners();
  }

  //* remove one product from cart
  void removeOneProductFromCart(String productId) {
    _cartProductItems.remove(productId);
    notifyListeners();
  }

  //* clear cart
  void clearAllCartItems() {
    _cartProductItems.clear();
    notifyListeners();
  }
}
