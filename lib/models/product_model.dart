import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  final String categoryName;
  final double originalPrice;
  final double offerPrice;
  final bool isOnOffer;
  final bool isPiece;

  
  ProductModel(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.categoryName,
      required this.originalPrice,
      required this.offerPrice,
      required this.isOnOffer,
      required this.isPiece});
}
