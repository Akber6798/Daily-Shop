import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  final String id, title, imageUrl, categoryName;
  final double originalPrice, offerPrice;
  final bool isOnOffer, isPiece;

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
