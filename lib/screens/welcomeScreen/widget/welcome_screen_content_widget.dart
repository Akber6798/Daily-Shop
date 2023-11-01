import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreenContentWidget extends StatelessWidget {
  const WelcomeScreenContentWidget(
      {super.key, required this.subText, required this.imageUrl});

  final String subText;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          "DAILY SHOP",
          style: AppTextStyle.instance.mainTextStyle(
              fSize: 30.sp,
              fWeight: FontWeight.w600,
              color: GetColorThemeService(context).headingTextColor),
        ),
        Text(
          subText,
          textAlign: TextAlign.center,
          style: AppTextStyle.instance.mainTextStyle(
              fSize: 15.sp,
              fWeight: FontWeight.w400,
              color: GetColorThemeService(context).textColor),
        ),
        const Spacer(
          flex: 2,
        ),
        FadedScaleAnimation(
          scaleDuration: const Duration(milliseconds: 400),
          fadeDuration: const Duration(milliseconds: 400),
          child: Image.asset(
            imageUrl,
            height: 280.h,
            width: 280.w,
          ),
        )
      ],
    );
  }
}
