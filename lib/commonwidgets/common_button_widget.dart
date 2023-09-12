import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonButtonWidget extends StatelessWidget {
  const CommonButtonWidget({
    super.key,
    required this.height,
    required this.width,
    required this.title,
    required this.onPressedFunction,
  });

  final double height;
  final double width;
  final String title;
  final Function onPressedFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressedFunction();
      },
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
          color: greenColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyle.instance.mainTextStyle(
                fSize: 14.sp, fWeight: FontWeight.w500, color: whiteColor),
          ),
        ),
      ),
    );
  }
}