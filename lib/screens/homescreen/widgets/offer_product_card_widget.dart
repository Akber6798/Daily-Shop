import 'package:daily_shop/commonwidgets/heart_icon_widget.dart';
import 'package:daily_shop/commonwidgets/price_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferProductCardWidget extends StatelessWidget {
  const OfferProductCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () {
          print("CLICK OFFER CARD");
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
                      "1 Kg",
                      style: AppTextStyle.instance.mainTextStyle(
                          fSize: 12,
                          fWeight: FontWeight.bold,
                          color: GetColorThemeService(context).textColor),
                    ),
                   const HeartIconWidget(),
                  ],
                ),
                Center(
                  child: FancyShimmerImage(
                    imageUrl:
                        "https://freepngimg.com/download/apple_fruit/24632-1-apple-fruit-transparent.png",
                    height: 80.h,
                    width: 110.w,
                    boxFit: BoxFit.fill,
                  ),
                ),
                const VerticalSpacingWidget(height: 5),
               const PriceWidget(
                  isOnOffer: true,
                  normalPrice: 100,
                  offerPrice: 60,
                  quantity: "1",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Apple",
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
