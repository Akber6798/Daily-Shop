// ignore_for_file: prefer_final_fields,, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_shop/models/product_model.dart';
import 'package:daily_shop/services/global_services.dart';
import 'package:flutter/material.dart';

class ProductController with ChangeNotifier {
  static List<ProductModel> _productList = [];

  //* get products from database
  Future<void> fetchProducts(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .get()
          .then((QuerySnapshot productSnapshot) {
        _productList = [];
        for (var element in productSnapshot.docs) {
          _productList.insert(
            0,
            ProductModel(
                id: element.get('id'),
                title: element.get('title'),
                imageUrl: element.get('imageUrl'),
                categoryName: element.get('categoryName'),
                originalPrice: double.parse(element.get('originalPrice')),
                offerPrice: element.get('offerPrice').toDouble(),
                isOnOffer: element.get('isOnOffer'),
                isPiece: element.get('isPiece')),
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

  //* to get the product list
  List<ProductModel> get getProductList {
    return _productList;
  }

  //* to get offer product list
  List<ProductModel> get getOfferProductList {
    return _productList.where((element) => element.isOnOffer).toList();
  }

  //* to get product by id
  ProductModel findProductById(String productId) {
    return _productList.firstWhere((element) => element.id == productId);
  }

  //* to get products as per category
  List<ProductModel> findProductByCategory(String categoryName) {
    return _productList
        .where(
          (element) => element.categoryName.toLowerCase().contains(
                categoryName.toLowerCase(),
              ),
        )
        .toList();
  }

  //* get product as per search
  List<ProductModel> searchProduct(String productName) {
    return _productList
        .where(
          (element) => element.title.toLowerCase().contains(
                productName.toLowerCase(),
              ),
        )
        .toList();
  }
}
