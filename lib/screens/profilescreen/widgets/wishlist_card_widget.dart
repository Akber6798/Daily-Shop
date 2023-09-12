import 'package:daily_shop/commonwidgets/heart_icon_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/consts/routes.dart';
import 'package:daily_shop/screens/homescreen/innerscreens/product_detail_screen.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistCardWidget extends StatelessWidget {
  const WishlistCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Routes.instance.push(
          context: context,
          newScreen: const ProductDetailScreen(),
        );
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
                    imageUrl:
                        "https://freepngimg.com/download/apple_fruit/24632-1-apple-fruit-transparent.png",
                    height: 70.h,
                    width: 100.w,
                    boxFit: BoxFit.fill,
                  ),
                  Column(
                    children: [
                      const VerticalSpacingWidget(height: 5),
                      HeartIconWidget(iconColor: redColor),
                      const VerticalSpacingWidget(height: 10),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          IconlyLight.buy,
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
                "Apple",
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
                  "₹ 100",
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
