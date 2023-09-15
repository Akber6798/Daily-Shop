import 'package:daily_shop/commonwidgets/common_button_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/screens/cartScreen/widget/cart_card_widget.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:daily_shop/services/global_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart (2)",
          style: AppTextStyle.instance.mainTextStyle(
              fSize: 20.sp,
              fWeight: FontWeight.w600,
              color: GetColorThemeService(context).headingTextColor),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              GlobalServices.instance.closingDailogue(
                context,
                "Delete",
                "Do you want delete?",
                () {},
              );
            },
            icon: Icon(IconlyLight.delete, color: redColor),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          children: [
            const VerticalSpacingWidget(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonButtonWidget(
                      height: 40,
                      width: 100,
                      title: "Order Now",
                      onPressedFunction: () {}),
                  FittedBox(
                    child: Text(
                      "Total: ₹ 1000",
                      style: AppTextStyle.instance.mainTextStyle(
                          fSize: 16.sp,
                          fWeight: FontWeight.w500,
                          color: GetColorThemeService(context).textColor),
                    ),
                  )
                ],
              ),
            ),
            const VerticalSpacingWidget(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: ((context, index) {
                  return const Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: CartCardWidget(),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
