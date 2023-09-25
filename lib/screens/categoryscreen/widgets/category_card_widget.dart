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
        Navigator.pushNamed(context, CategoryProductScreen.routeName,arguments: title);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
          border: Border.all(
              width: .5.w,
              color: GetColorThemeService(context).headingTextColor),
        ),
        child: Column(
          children: [
          const  VerticalSpacingWidget(height: 5),
          //! image
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 120.h,
                width: 120.w,
                child: Image(
                  image: AssetImage(image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            //! title
            Text(
              title,
              style: AppTextStyle.instance.mainTextStyle(
                  fSize: 20,
                  fWeight: FontWeight.w600,
                  color: GetColorThemeService(context).headingTextColor),
            )
          ],
        ),
      ),
    );
  }
}
