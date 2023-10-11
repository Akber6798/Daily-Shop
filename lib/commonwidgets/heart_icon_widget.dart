// ignore_for_file: use_build_context_synchronously

import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/firebase_consts.dart';
import 'package:daily_shop/controllers/product_controller.dart';
import 'package:daily_shop/controllers/wishlist_controller.dart';
import 'package:daily_shop/services/global_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class HeartIconWidget extends StatefulWidget {
  const HeartIconWidget(
      {super.key, required this.productId, this.isInWishlist = false});
  final String productId;
  final bool? isInWishlist;

  @override
  State<HeartIconWidget> createState() => _HeartIconWidgetState();
}

class _HeartIconWidgetState extends State<HeartIconWidget> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final wishlistController = Provider.of<WishlistController>(context);
    final productProvider = Provider.of<ProductController>(context);
    final currentProduct = productProvider.findProductById(widget.productId);
    return GestureDetector(
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        try {
          final User? user = authenticationInstance.currentUser;
          if (user == null) {
            GlobalServices.instance
                .errorDailogue(context, "No user found \nPlease login..");
            return;
          }
          if (widget.isInWishlist == false && widget.isInWishlist != null) {
            await wishlistController.addProductToWishlist(
                productId: widget.productId, context: context);
          } else {
            wishlistController.removeOneProductFromWishlist(
                wishlistId: wishlistController
                    .getWishlistProductItems[currentProduct.id]!.id,
                productId: widget.productId);
          }
          await wishlistController.fetchWishlistProducts(context: context);
          setState(() {
            isLoading = false;
          });
        } catch (error) {
          GlobalServices.instance.errorDailogue(
            context,
            error.toString(),
          );
        } finally {
          setState(() {
            isLoading = false;
          });
        }
      },
      child: isLoading
          ? Center(
            child: SpinKitPumpingHeart(
                color: redColor,
                size: 20.0,
              ),
          )
          : Icon(
              widget.isInWishlist != null && widget.isInWishlist == true
                  ? IconlyBold.heart
                  : IconlyLight.heart,
              size: 21.sp,
              color: redColor,
            ),
    );
  }
}
