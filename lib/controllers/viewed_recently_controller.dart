// ignore_for_file: prefer_final_fields

import 'package:daily_shop/models/viewed_recently_model.dart';
import 'package:flutter/material.dart';

class ViewedRecentlyController with ChangeNotifier {
  Map<String, ViewedRecentlyModel> _viewedRecentlyProductItems = {};

  //* for get viewed recently items
  Map<String, ViewedRecentlyModel> get getViewedRecentlyProductItems {
    return _viewedRecentlyProductItems;
  }

  //* to add product to recently viewed
  void addProductToRecentlyViewed({required productId}) {
    _viewedRecentlyProductItems.putIfAbsent(
      productId,
      () => ViewedRecentlyModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          productId: productId),
    );
    notifyListeners();
  }

  //* clear viewed recently products
  void clearAllViewedRecntlyItems() {
    _viewedRecentlyProductItems.clear();
    notifyListeners();
  }
}
