// ignore_for_file: use_build_context_synchronously

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:daily_shop/commonwidgets/heart_icon_widget.dart';
import 'package:daily_shop/commonwidgets/price_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/consts/firebase_consts.dart';
import 'package:daily_shop/controllers/cart_controller.dart';
import 'package:daily_shop/controllers/wishlist_controller.dart';
import 'package:daily_shop/models/product_model.dart';
import 'package:daily_shop/screens/homescreen/inner_screens/product_detail_screen.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:daily_shop/services/global_services.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OfferProductCardWidget extends StatelessWidget {
  const OfferProductCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = authenticationInstance.currentUser;
    final productModel = Provider.of<ProductModel>(context);
    final cartController = Provider.of<CartController>(context);
    final wishlistController = Provider.of<WishlistController>(context);
    bool? isInWishlist =
        wishlistController.getWishlistProductItems.containsKey(productModel.id);
    bool isInCart =
        cartController.getCartProductItems.containsKey(productModel.id);
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).cardColor,
      //! go to product details
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, ProductDetailScreen.routeName,
              arguments: productModel.id);
        },
        child: SizedBox(
          width: 140.w,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //! quantity
                    Text(
                      productModel.isPiece ? "1 Piece" : "1 Kg",
                      style: AppTextStyle.instance.mainTextStyle(
                          fSize: 12,
                          fWeight: FontWeight.bold,
                          color: GetColorThemeService(context).textColor),
                    ),
                    //! favourite button
                    HeartIconWidget(
                      productId: productModel.id,
                      isInWishlist: isInWishlist,
                    ),
                  ],
                ),
                Center(
                  //! image
                  child: FadedScaleAnimation(
                    scaleDuration: const Duration(milliseconds: 400),
                    fadeDuration: const Duration(milliseconds: 400),
                    child: FancyShimmerImage(
                      imageUrl: productModel.imageUrl,
                      height: 70.h,
                      width: 100.w,
                      boxFit: BoxFit.contain,
                    ),
                  ),
                ),
                const VerticalSpacingWidget(height: 5),
                //! price
                PriceWidget(
                  isOnOffer: true,
                  normalPrice: productModel.originalPrice,
                  offerPrice: productModel.offerPrice,
                  quantity: "1",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //! title
                    Flexible(
                      flex: 2,
                      child: Text(
                        productModel.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.instance.mainTextStyle(
                            fSize: 15.sp,
                            fWeight: FontWeight.w400,
                            color: GetColorThemeService(context).textColor),
                      ),
                    ),
                    //! to add to cart
                    Flexible(
                      flex: 1,
                      child: IconButton(
                        onPressed: () async {
                          if (user == null) {
                            GlobalServices.instance.errorDailogue(
                                context, "No user found \nPlease login..");
                            return;
                          }
                          await cartController.addProductToCart(
                              productId: productModel.id,
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
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
