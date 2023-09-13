import 'package:daily_shop/commonwidgets/common_button_widget.dart';
import 'package:daily_shop/commonwidgets/horizontal_spacing_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/consts/routes.dart';
import 'package:daily_shop/screens/homescreen/innerscreens/product_detail_screen.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewedCardWidget extends StatelessWidget {
  const ViewedCardWidget({super.key});

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
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FancyShimmerImage(
                imageUrl:
                    "https://freepngimg.com/download/apple_fruit/24632-1-apple-fruit-transparent.png",
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
                  "Apple",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.instance.mainTextStyle(
                      fSize: 16.sp,
                      fWeight: FontWeight.w500,
                      color: GetColorThemeService(context).textColor),
                ),
                const VerticalSpacingWidget(height: 5),
                Text(
                  "₹ 1000",
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
              padding: EdgeInsets.fromLTRB(0, 5.h, 10.w, 5.h),
              child: CommonButtonWidget(
                  height: 40, width: 40, title: "+", onPressedFunction: () {}),
            )
          ],
        ),
      ),
    );
  }
}
