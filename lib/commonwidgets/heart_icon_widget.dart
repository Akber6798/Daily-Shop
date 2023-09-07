import 'package:daily_shop/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeartIconWidget extends StatelessWidget {
  const HeartIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       print("CLICK FAVOURITE");
      },
      child: Icon(IconlyLight.heart,
      size: 21.sp,
      color: redColor,
      ),
    );
  }
}