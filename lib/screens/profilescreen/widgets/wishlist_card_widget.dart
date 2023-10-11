// ignore_for_file: use_build_context_synchronously

import 'package:daily_shop/commonwidgets/heart_icon_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/controllers/cart_controller.dart';
import 'package:daily_shop/controllers/product_controller.dart';
import 'package:daily_shop/controllers/wishlist_controller.dart';
import 'package:daily_shop/models/wishlist_model.dart';
import 'package:daily_shop/screens/homescreen/inner_screens/product_detail_screen.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WishlistCardWidget extends StatelessWidget {
  const WishlistCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistModel = Provider.of<WishlistModel>(context);
    final productController = Provider.of<ProductController>(context);
    final cartController = Provider.of<CartController>(context);
    final currentProduct =
        productController.findProductById(wishlistModel.productId);
    double productPrice = currentProduct.isOnOffer
        ? currentProduct.offerPrice
        : currentProduct.originalPrice;
    final wishlistController = Provider.of<WishlistController>(context);
    bool? isInWishlist = wishlistController.getWishlistProductItems
        .containsKey(currentProduct.id);
    bool isInCart =
        cartController.getCartProductItems.containsKey(currentProduct.id);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailScreen.routeName,
            arguments: wishlistModel.productId);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
          border: Border.all(
              width: .5.w,
              color: GetColorThemeService(context).headingTextColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FancyShimmerImage(
                    imageUrl: currentProduct.imageUrl,
                    height: 70.h,
                    width: 100.w,
                    boxFit: BoxFit.fill,
                  ),
                  Column(
                    children: [
                      const VerticalSpacingWidget(height: 5),
                      HeartIconWidget(
                        productId: currentProduct.id,
                        isInWishlist: isInWishlist,
                      ),
                      const VerticalSpacingWidget(height: 10),
                      IconButton(
                        onPressed: () async {
                          await cartController.addProductToCart(
                              productId: currentProduct.id,
                              quantity: 1,
                              context: context);
                          await cartController.fetchCartProducts(
                              context: context);
                        },
                        icon: Icon(
                          isInCart ? IconlyBold.bag : IconlyLight.bag,
                          color: GetColorThemeService(context).headingTextColor,
                          size: 21.sp,
                        ),
                      )
                    ],
                  )
                ],
              ),
              const VerticalSpacingWidget(height: 10),
              Text(
                currentProduct.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.instance.mainTextStyle(
                    fSize: 17.sp,
                    fWeight: FontWeight.w500,
                    color: GetColorThemeService(context).textColor),
              ),
              const VerticalSpacingWidget(height: 5),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "₹ ${productPrice.toStringAsFixed(2)}",
                  style: AppTextStyle.instance.mainTextStyle(
                      fSize: 18.sp,
                      fWeight: FontWeight.w600,
                      color: GetColorThemeService(context).headingTextColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
