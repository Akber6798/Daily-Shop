import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget(
      {super.key, required this.emptyAnimation, required this.emptyTitle});

  final String emptyAnimation;
  final String emptyTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const VerticalSpacingWidget(height: 40),
        Lottie.asset(emptyAnimation),
        const VerticalSpacingWidget(height: 50),
        Text(
          emptyTitle,
          style: AppTextStyle.instance.mainTextStyle(
              fSize: 22,
              fWeight: FontWeight.w600,
              color: GetColorThemeService(context).headingTextColor),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
