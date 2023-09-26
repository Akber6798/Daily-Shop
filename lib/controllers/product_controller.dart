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
            "https://www.jiomart.com/images/product/original/590000090/potato-1-kg-product-images-o590000090-p590000090-0-202207291750.jpg?im=Resize=(420,420)",
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
            "https://amirthamnaturals.in/wp-content/uploads/2020/11/pngguru.com-4-600x394.png",
        categoryName: "Vegitables",
        originalPrice: 40,
        offerPrice: 20,
        isOnOffer: false,
        isPiece: false),
    ProductModel(
        id: "104",
        title: "Mango",
        imageUrl:
            "https://www.bigbasket.com/media/uploads/p/xxl/40075207_6-fresho-kesar-mango.jpg",
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
        originalPrice: 70,
        offerPrice: 50,
        isOnOffer: true,
        isPiece: true),
  ];
}
