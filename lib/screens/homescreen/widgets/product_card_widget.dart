// ignore_for_file: use_build_context_synchronously

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:daily_shop/commonwidgets/heart_icon_widget.dart';
import 'package:daily_shop/commonwidgets/horizontal_spacing_widget.dart';
import 'package:daily_shop/commonwidgets/price_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_colors.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductCardWidegt extends StatefulWidget {
  const ProductCardWidegt({
    super.key,
  });

  @override
  State<ProductCardWidegt> createState() => _ProductCardWidegtState();
}

class _ProductCardWidegtState extends State<ProductCardWidegt> {
  final quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    quantityController.text = "1";
  }

  @override
  Widget build(BuildContext context) {
    final User? user = authenticationInstance.currentUser;
    final productModel = Provider.of<ProductModel>(context);
    final cartController = Provider.of<CartController>(context);
    final wishlistController = Provider.of<WishlistController>(context);
    bool isInCart =
        cartController.getCartProductItems.containsKey(productModel.id);
    bool? isInWishlist =
        wishlistController.getWishlistProductItems.containsKey(productModel.id);
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).cardColor,
      //! go to product details
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, ProductDetailScreen.routeName,
              arguments: productModel.id);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpacingWidget(height: 10),
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
              const VerticalSpacingWidget(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    //! title
                    child: Text(
                      productModel.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.instance.mainTextStyle(
                          fSize: 17.sp,
                          fWeight: FontWeight.w500,
                          color: GetColorThemeService(context).textColor),
                    ),
                  ),
                  //! favourite button
                  Flexible(
                    flex: 1,
                    child: HeartIconWidget(
                      productId: productModel.id,
                      isInWishlist: isInWishlist,
                    ),
                  ),
                ],
              ),
              //! price
              PriceWidget(
                  normalPrice: productModel.originalPrice,
                  offerPrice: productModel.offerPrice,
                  quantity: quantityController.text,
                  isOnOffer: productModel.isOnOffer ? true : false),
              //! quantity
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    productModel.isPiece ? "Piece" : "Kg",
                    style: AppTextStyle.instance.mainTextStyle(
                        fSize: 15,
                        fWeight: FontWeight.bold,
                        color: GetColorThemeService(context).textColor),
                  ),
                  const HorizontalSpacingWidget(width: 10),
                  SizedBox(
                    height: 30.h,
                    width: 40.w,
                    child: TextFormField(
                      controller: quantityController,
                      cursorColor:
                          GetColorThemeService(context).headingTextColor,
                      keyboardType: TextInputType.number,
                      onChanged: (onValue) {
                        setState(() {
                          if (onValue.isEmpty) {
                            quantityController.text = "0";
                          }
                        });
                      },
                      style: AppTextStyle().mainTextStyle(
                          fSize: 15,
                          fWeight: FontWeight.w500,
                          color: GetColorThemeService(context).textColor),
                      maxLength: 2,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                        counterText: "",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: GetColorThemeService(context)
                                  .headingTextColor,
                              width: 0.8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: GetColorThemeService(context)
                                  .headingTextColor,
                              width: 0.8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const VerticalSpacingWidget(height: 10),
              //! add to cart
              InkWell(
                onTap: isInCart
                    ? null
                    : () async {
                        if (user == null) {
                          GlobalServices.instance.errorDailogue(
                              context, "No user found \nPlease login..");
                          return;
                        }
                        await cartController.addProductToCart(
                            productId: productModel.id,
                            quantity: int.parse(quantityController.text),
                            context: context);
                        await cartController.fetchCartProducts(
                            context: context);
                      },
                child: Container(
                  height: 30.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 0.8,
                        color: GetColorThemeService(context).headingTextColor),
                  ),
                  child: Center(
                    child: Text(
                      isInCart ? "IN CART" : "ADD TO CART",
                      style: AppTextStyle().mainTextStyle(
                          fSize: 13,
                          fWeight: FontWeight.bold,
                          color: isInCart
                              ? redColor
                              : GetColorThemeService(context).headingTextColor),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    quantityController.dispose();
  }
}
