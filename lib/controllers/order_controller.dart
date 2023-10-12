// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_shop/models/order_model.dart';
import 'package:daily_shop/services/global_services.dart';
import 'package:flutter/material.dart';

class OrderController with ChangeNotifier {
  static List<OrderModel> _ordersList = [];

  //* to get the orders list
  List<OrderModel> get getOrdersList {
    return _ordersList;
  }

  //* get orders from database
  Future<void> fetchOrders(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .get()
          .then((QuerySnapshot ordersSnapshot) {
        _ordersList = [];
        for (var element in ordersSnapshot.docs) {
          _ordersList.insert(
            0,
            OrderModel(
              orderId: element.get('orderId'),
              userId: element.get('userId'),
              productId: element.get('productId'),
              userName: element.get('userName'),
              price: element.get('price').toString(),
              imageUrl: element.get('imageUrl'),
              quantity: element.get('quantity').toString(),
              orderDate: element.get('orderDate'),
            ),
          );
        }
      });
    } on FirebaseException catch (firebaseError) {
      GlobalServices.instance
          .errorDailogue(context, firebaseError.message.toString());
    } catch (error) {
      GlobalServices.instance.errorDailogue(context, error.toString());
    }
    notifyListeners();
  }
}
