// ignore_for_file: use_build_context_synchronously

import 'package:daily_shop/commonwidgets/horizontal_spacing_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/controllers/cart_controller.dart';
import 'package:daily_shop/controllers/product_controller.dart';
import 'package:daily_shop/models/viewed_recently_model.dart';
import 'package:daily_shop/screens/homescreen/inner_screens/product_detail_screen.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ViewedRecentlyCardWidget extends StatelessWidget {
  const ViewedRecentlyCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);
    final viewedRecentlyModel = Provider.of<ViewedRecentlyModel>(context);
    final currentProduct =
        productController.findProductById(viewedRecentlyModel.productId);
    double productPrice = currentProduct.isOnOffer
        ? currentProduct.offerPrice
        : currentProduct.originalPrice;
    final cartController = Provider.of<CartController>(context);
    bool isInCart =
        cartController.getCartProductItems.containsKey(currentProduct.id);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailScreen.routeName,
            arguments: viewedRecentlyModel.productId);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FancyShimmerImage(
                imageUrl: currentProduct.imageUrl,
                height: 60.h,
                width: 90.w,
                boxFit: BoxFit.fill,
              ),
            ),
            const HorizontalSpacingWidget(width: 10),
            Column(
              children: [
                const VerticalSpacingWidget(height: 5),
                Text(
                  currentProduct.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.instance.mainTextStyle(
                      fSize: 16.sp,
                      fWeight: FontWeight.w500,
                      color: GetColorThemeService(context).textColor),
                ),
                const VerticalSpacingWidget(height: 5),
                Text(
                  "₹ ${productPrice.toStringAsFixed(2)}",
                  style: AppTextStyle.instance.mainTextStyle(
                      fSize: 13.sp,
                      fWeight: FontWeight.w400,
                      color: GetColorThemeService(context).textColor),
                  maxLines: 1,
                )
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: Material(
                borderRadius: BorderRadius.circular(12),
                color: GetColorThemeService(context).headingTextColor,
                child: InkWell(
                  onTap: isInCart
                      ? null
                      : () async {
                          await cartController.addProductToCart(
                              productId: currentProduct.id,
                              quantity: 1,
                              context: context);
                          await cartController.fetchCartProducts(
                              context: context);
                        },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      isInCart ? Icons.check : IconlyBold.plus,
                      color: whiteColor,
                      size: 21.sp,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
