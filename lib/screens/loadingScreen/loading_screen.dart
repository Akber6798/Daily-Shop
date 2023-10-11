// ignore_for_file: use_build_context_synchronously

import 'package:daily_shop/commonwidgets/bottom_navigation.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/firebase_consts.dart';
import 'package:daily_shop/controllers/cart_controller.dart';
import 'package:daily_shop/controllers/product_controller.dart';
import 'package:daily_shop/controllers/wishlist_controller.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 5), () async {
      final productController =
          Provider.of<ProductController>(context, listen: false);
      final cartController =
          Provider.of<CartController>(context, listen: false);
      final wishlistController =
          Provider.of<WishlistController>(context, listen: false);
      final User? user = authenticationInstance.currentUser;
      if (user == null) {
        await productController.fetchProducts(context);
        await cartController.clearAllCartItems();
        await wishlistController.clearAllWishlistItems();
      } else {
        await productController.fetchProducts(context);
        await cartController.fetchCartProducts(context: context);
        await wishlistController.fetchWishlistProducts(context: context);
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavigation(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            height: 70.h,
            width: 70.w,
            image: const AssetImage("assets/icons/logo.png"),
          ),
          const VerticalSpacingWidget(height: 30),
          SpinKitFadingCircle(
            color: GetColorThemeService(context).headingTextColor,
            size: 50.0,
          ),
        ],
      ),
    ));
  }
}
