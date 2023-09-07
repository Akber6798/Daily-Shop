import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  final String title;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onPressed();
      },
      title: Text(
        title,
        style: AppTextStyle.instance.mainTextStyle(
            fSize: 19,
            fWeight: FontWeight.w400,
            color: GetColorThemeService(context).textColor),
      ),
      leading: Icon(
        icon,
        color: GetColorThemeService(context).iconColor,
        size: 24.sp,
      ),
      trailing: Icon(
        IconlyLight.arrowRight2,
        color: GetColorThemeService(context).iconColor,
        size: 25.sp,
      ),
    );
  }
}
