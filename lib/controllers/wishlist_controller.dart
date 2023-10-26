// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_shop/consts/firebase_consts.dart';
import 'package:daily_shop/models/wishlist_model.dart';
import 'package:daily_shop/services/global_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class WishlistController with ChangeNotifier {
  Map<String, WishlistModel> _wishlistProductItems = {};

  //* for get wishlist items
  Map<String, WishlistModel> get getWishlistProductItems {
    return _wishlistProductItems;
  }

  // //* add and remove products to wishlist
  // void addAndRemoveProductToWishlist({required productId}) {
  //   if (_wishlistProductItems.containsKey(productId)) {
  //     removeOneProductFromWishlist(productId);
  //   } else {
  //     _wishlistProductItems.putIfAbsent(
  //       productId,
  //       () => WishlistModel(
  //           id: DateTime.now().millisecondsSinceEpoch.toString(),
  //           productId: productId),
  //     );
  //     notifyListeners();
  //   }
  // }

  //* fetch wishlist products from database
  Future<void> fetchWishlistProducts({required BuildContext context}) async {
    final User? user = authenticationInstance.currentUser;
    if (user == null) {
      return;
    }
    try {
      final DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection("userDetails")
          .doc(user.uid)
          .get();
      if (!userData.exists) {
        return;
      }
      final userWishList = userData.get('userWishlist') as List<dynamic>;
      for (int index = 0; index < userWishList.length; index++) {
        final wishistItemData = userWishList[index];
        final productId = wishistItemData['productId'];
        _wishlistProductItems.putIfAbsent(
          productId,
          () => WishlistModel(
            id: wishistItemData['wishlistId'],
            productId: productId,
          ),
        );
      }
      notifyListeners();
    } catch (error) {
      GlobalServices.instance.errorDailogue(
        context,
        error.toString(),
      );
    }
  }

//* add to wishlist
  Future<void> addProductToWishlist(
      {required String productId, required BuildContext context}) async {
    final User? user = authenticationInstance.currentUser;
    final userId = user!.uid;
    final wishListId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('userDetails').doc(userId).update({
        'userWishlist': FieldValue.arrayUnion([
          {'wishlistId': wishListId, 'productId': productId}
        ])
      });
      GlobalServices.instance
          .showToastMessage("Item has been added to your wishlist");
    } catch (error) {
      GlobalServices.instance.errorDailogue(context, error.toString());
    }
    notifyListeners();
  }

  //* remove one product from wishlist
  Future<void> removeOneProductFromWishlist({
    required String wishlistId,
    required String productId,
  }) async {
    final User? user = authenticationInstance.currentUser;
    await FirebaseFirestore.instance
        .collection("userDetails")
        .doc(user!.uid)
        .update({
      'userWishlist': FieldValue.arrayRemove([
        {
          'wishlistId': wishlistId,
          'productId': productId,
        }
      ])
    });
    _wishlistProductItems.remove(productId);
    notifyListeners();
  }

  //* clear wishlist
  Future<void> clearAllWishlistItems() async {
    final User? user = authenticationInstance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection("userDetails")
          .doc(user.uid)
          .update(
        {
          'userWishlist': [],
        },
      );
      _wishlistProductItems.clear();
      notifyListeners();
    } else {
      _wishlistProductItems.clear();
    }
  }
}
