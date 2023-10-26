import 'package:daily_shop/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KGControllerWidget extends StatelessWidget {
  const KGControllerWidget(
      {super.key,
      required this.color,
      required this.clickedFunction,
      required this.icon, required this.height, required this.width});

  final Color color;
  final Function clickedFunction;
  final IconData icon;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width.h,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          clickedFunction();
        },
        child: Center(
          child: Icon(
            icon,
            color: whiteColor,
          ),
        ),
      ),
    );
  }
}
