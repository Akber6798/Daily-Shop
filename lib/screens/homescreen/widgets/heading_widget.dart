import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:flutter/material.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({
    super.key,
    required this.title,
    required this.viewAllFunction,
  });

  final String title;
  final Function viewAllFunction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.instance.mainTextStyle(
              fSize: 20,
              fWeight: FontWeight.w500,
              color: GetColorThemeService(context).headingTextColor),
        ),
        TextButton(
          onPressed: () {
            viewAllFunction();
          },
          child: Text(
            "View All",
            style: AppTextStyle.instance.mainTextStyle(
                fSize: 13, fWeight: FontWeight.w400, color: redColor),
          ),
        )
      ],
    );
  }
}
