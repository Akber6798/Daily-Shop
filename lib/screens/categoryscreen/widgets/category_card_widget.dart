import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/screens/categoryScreen/inner_screens/category_product_screen.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget(
      {super.key, required this.image, required this.title});

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CategoryProductScreen.routeName,
            arguments: title);
      },
      child: Column(
        children: [
          FadedScaleAnimation(
            scaleDuration: const Duration(milliseconds: 400),
            fadeDuration: const Duration(milliseconds: 400),
            child: CircleAvatar(
              radius: 45.sp,
              backgroundColor: Colors.green[100],
              backgroundImage: AssetImage(
                image,
              ),
            ),
          ),
          VerticalSpacingWidget(height: 10),
          Text(
            title,
            style: AppTextStyle.instance.mainTextStyle(
                fSize: 14.5,
                fWeight: FontWeight.w500,
                color: GetColorThemeService(context).headingTextColor),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
