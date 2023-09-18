import 'package:daily_shop/commonwidgets/heart_icon_widget.dart';
import 'package:daily_shop/commonwidgets/price_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/models/product_model.dart';
import 'package:daily_shop/screens/homescreen/inner_screens/product_detail_screen.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OfferProductCardWidget extends StatelessWidget {
  const OfferProductCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, ProductDetailScreen.routeName,
              arguments: productModel.id);
        },
        child: SizedBox(
          height: 170.h,
          width: 140.w,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      productModel.isPiece ? "1 Piece" : "1 Kg",
                      style: AppTextStyle.instance.mainTextStyle(
                          fSize: 12,
                          fWeight: FontWeight.bold,
                          color: GetColorThemeService(context).textColor),
                    ),
                    HeartIconWidget(
                      iconColor: redColor,
                    ),
                  ],
                ),
                Center(
                  child: FancyShimmerImage(
                    imageUrl: productModel.imageUrl,
                    height: 80.h,
                    width: 110.w,
                    boxFit: BoxFit.fill,
                  ),
                ),
                const VerticalSpacingWidget(height: 5),
                PriceWidget(
                  isOnOffer: true,
                  normalPrice: productModel.originalPrice,
                  offerPrice: productModel.offerPrice,
                  quantity: "1",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
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
                    Icon(
                      IconlyLight.bag,
                      color: GetColorThemeService(context).headingTextColor,
                      size: 21.sp,
                    ),
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
