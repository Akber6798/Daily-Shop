import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Apple x12",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyle.instance.mainTextStyle(
            fSize: 16.sp,
            fWeight: FontWeight.w500,
            color: GetColorThemeService(context).headingTextColor),
      ),
      subtitle:const Text("Paid ₹ 1200"),
      trailing:const Text("31/03/2023"),
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: FancyShimmerImage(
          imageUrl:
              "https://freepngimg.com/download/apple_fruit/24632-1-apple-fruit-transparent.png",
          height: 50.h,
          width: 85.w,
          boxFit: BoxFit.fill,
        ),
      ),
    );
  }
}
