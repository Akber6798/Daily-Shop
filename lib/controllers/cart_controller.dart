// ignore_for_file: prefer_final_fields, unnecessary_null_comparison, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/firebase_consts.dart';
import 'package:daily_shop/models/cart_model.dart';
import 'package:daily_shop/services/global_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class CartController with ChangeNotifier {
  Map<String, CartModel> _cartProductItems = {};

  //* for get cart items
  Map<String, CartModel> get getCartProductItems {
    return _cartProductItems;
  }

  //* add products to cart
  Future<void> addProductToCart(
      {required String productId,
      required int quantity,
      required BuildContext context}) async {
    final User? user = authenticationInstance.currentUser;
    final userId = user!.uid;
    final cartId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('userDetails').doc(userId).update({
        'userCartList': FieldValue.arrayUnion([
          {'cartId': cartId, 'productId': productId, 'quantity': quantity}
        ])
      });
      Fluttertoast.showToast(
          msg: "Item has been added to your cart",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade600,
          textColor: whiteColor,
          fontSize: 16.sp);
    } catch (error) {
      GlobalServices.instance.errorDailogue(context, error.toString());
    }
    notifyListeners();
  }

  //* fetch cart products from database
  Future<void> fetchCartProducts({required BuildContext context}) async {
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
      final userCartList = userData.get('userCartList') as List<dynamic>;
      for (int index = 0; index < userCartList.length; index++) {
        final cartItemData = userCartList[index];
        final productId = cartItemData['productId'];
        _cartProductItems.putIfAbsent(
          productId,
          () => CartModel(
            id: cartItemData['cartId'],
            productId: productId,
            quantity: cartItemData['quantity'],
          ),
        );
      }
      notifyListeners();
    } catch (error) {
      GlobalServices.instance.errorDailogue(context, error.toString());
    }
  }

  //* remove one product from cart
  Future<void> removeOneProductFromCart(
      {required String cartId,
      required String productId,
      required int quantity}) async {
    final User? user = authenticationInstance.currentUser;
    await FirebaseFirestore.instance
        .collection("userDetails")
        .doc(user!.uid)
        .update({
      'userCartList': FieldValue.arrayRemove([
        {
          'cartId': cartId,
          'productId': productId,
          'quantity': quantity,
        }
      ])
    });
    _cartProductItems.remove(productId);
    notifyListeners();
  }



  Future<void> clearAllCartItems() async {
    final User? user = authenticationInstance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection("userDetails")
          .doc(user.uid)
          .update({
        'userCartList': [],
      });
      _cartProductItems.clear();
      notifyListeners();
    } else {
      _cartProductItems.clear();
    }
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
}
