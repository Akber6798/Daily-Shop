// ignore_for_file: prefer_final_fields

import 'package:daily_shop/models/wishlist_model.dart';
import 'package:flutter/material.dart';

class WishlistController with ChangeNotifier {
  Map<String, WishlistModel> _wishlistProductItems = {};

  //* for get wishlist items
  Map<String, WishlistModel> get getWishlistProductItems {
    return _wishlistProductItems;
  }

  //* add and remove products to wishlist
  void addAndRemoveProductToWishlist({required productId}) {
    if (_wishlistProductItems.containsKey(productId)) {
      removeOneProductFromWishlist(productId);
    } else {
      _wishlistProductItems.putIfAbsent(
        productId,
        () => WishlistModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            productId: productId),
      );
      notifyListeners();
    }
  }

  //* remove one product from wishlist
  void removeOneProductFromWishlist(String productId) {
    _wishlistProductItems.remove(productId);
    notifyListeners();
  }

  //* clear wishlist
  void clearAllWishlistItems() {
    _wishlistProductItems.clear();
    notifyListeners();
  }
}
