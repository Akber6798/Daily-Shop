import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/consts/routes.dart';
import 'package:daily_shop/screens/homescreen/innerscreens/all_products_screen.dart';
import 'package:daily_shop/screens/homescreen/innerscreens/offer_all_products_screen.dart';
import 'package:daily_shop/screens/homescreen/widgets/ad_offer_widget.dart';
import 'package:daily_shop/screens/homescreen/widgets/heading_widget.dart';
import 'package:daily_shop/screens/homescreen/widgets/offer_product_card_widget.dart';
import 'package:daily_shop/screens/homescreen/widgets/product_card_widget.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalSpacingWidget(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "DAILY SHOP",
                    style: AppTextStyle.instance.mainTextStyle(
                        fSize: 20,
                        fWeight: FontWeight.w600,
                        color: GetColorThemeService(context).headingTextColor),
                  ),
                  Image(
                    height: 30.h,
                    width: 30.w,
                    image: const AssetImage("assets/icons/logo.png"),
                  )
                ],
              ),
              const VerticalSpacingWidget(height: 20),
              const AdOfferWidget(),
              const VerticalSpacingWidget(height: 10),
              HeadingWidget(
                  title: "Today Offers",
                  viewAllFunction: () {
                    Routes.instance.push(
                      context: context,
                      newScreen: const OfferAllProductsScreen(),
                    );
                  }),
              SizedBox(
                height: 170.h,
                child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 7, 0),
                        child: OfferProductCardWidget(),
                      );
                    }),
              ),
              HeadingWidget(
                  title: "All Products",
                  viewAllFunction: () {
                    Routes.instance.push(
                      context: context,
                      newScreen: const AllProductsScreen(),
                    );
                  }),
              GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 7.0,
                    mainAxisSpacing: 7.0,
                    childAspectRatio: 0.75),
                itemBuilder: ((context, index) {
                  return ProductCardWidegt();
                }),
              ),
              const VerticalSpacingWidget(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
