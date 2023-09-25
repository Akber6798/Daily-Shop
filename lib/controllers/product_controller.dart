// ignore_for_file: prefer_final_fields

import 'package:daily_shop/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductController with ChangeNotifier {
  
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

  List<ProductModel> _productList = [
    ProductModel(
        id: "100",
        title: "Apple",
        imageUrl:
            "https://freepngimg.com/download/apple_fruit/24632-1-apple-fruit-transparent.png",
        categoryName: "Fruites",
        originalPrice: 120,
        offerPrice: 60,
        isOnOffer: false,
        isPiece: false),
    ProductModel(
        id: "101",
        title: "Potato",
        imageUrl:
            "https://w7.pngwing.com/pngs/74/390/png-transparent-mashed-potato-french-fries-potato-wedges-baked-potato-potato-chip-vegetable-food-baking-tomato-thumbnail.png",
        categoryName: "Vegitables",
        originalPrice: 40,
        offerPrice: 30,
        isOnOffer: true,
        isPiece: false),
    ProductModel(
        id: "102",
        title: "Cashew",
        imageUrl:
            "https://freepngimg.com/download/cashew/145702-nut-cashew-bowl-download-free-image.png",
        categoryName: "Nuts",
        originalPrice: 400,
        offerPrice: 350,
        isOnOffer: false,
        isPiece: true),
    ProductModel(
        id: "103",
        title: "Tomato",
        imageUrl:
            "https://w1.pngwing.com/pngs/720/511/png-transparent-fruits-and-vegetables-berries-juice-food-list-of-culinary-fruits-tomato-nuts-n-spices-ingredient-thumbnail.png",
        categoryName: "Vegitables",
        originalPrice: 40,
        offerPrice: 20,
        isOnOffer: false,
        isPiece: false),
    ProductModel(
        id: "104",
        title: "Mango",
        imageUrl:
            "https://w7.pngwing.com/pngs/446/952/png-transparent-ripe-mangos-banganapalle-alphonso-mango-fruit-benishan-mango-natural-foods-food-citrus-thumbnail.png",
        categoryName: "Fruites",
        originalPrice: 120,
        offerPrice: 100,
        isOnOffer: false,
        isPiece: false),
    ProductModel(
        id: "105",
        title: "Cumin",
        imageUrl:
            "https://t3.ftcdn.net/jpg/01/95/20/82/360_F_195208265_hcwcxDwqtH41uKAnJ0gNZghjriJytbnR.jpg",
        categoryName: "Spices",
        originalPrice: 300,
        offerPrice: 200,
        isOnOffer: true,
        isPiece: false),
    ProductModel(
        id: "106",
        title: "Dragon fruite",
        imageUrl:
            "https://media.istockphoto.com/id/606230354/photo/dragon-fruit-isolated.jpg?s=612x612&w=0&k=20&c=endAwrFRx9oSVcwJExjDdKc9wG2hVx4UJFnFptIg7-Y=",
        categoryName: "Fruites",
        originalPrice: 250,
        offerPrice: 150,
        isOnOffer: true,
        isPiece: true),
  ];
}
