import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/screens/profileScreen/widgets/wishlist_card_widget.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:daily_shop/services/global_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/whislist';
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Whishlist (2)",
          style: AppTextStyle.instance.mainTextStyle(
              fSize: 20.sp,
              fWeight: FontWeight.w600,
              color: GetColorThemeService(context).headingTextColor),
        ),
        actions: [
          IconButton(
            onPressed: () {
              GlobalServices.instance.closingDailogue(
                context,
                "Delete",
                "Do you want to delete?",
                () {},
              );
            },
            icon: Icon(IconlyLight.delete, color: redColor),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              const VerticalSpacingWidget(height: 15),
              GridView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 7,
                      childAspectRatio: .95),
                  itemBuilder: (context, index) {
                    return const WishlistCardWidget();
                  }),
              const VerticalSpacingWidget(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
