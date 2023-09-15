import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/screens/profileScreen/widgets/order_card_widget.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Orders",
          style: AppTextStyle.instance.mainTextStyle(
              fSize: 20.sp,
              fWeight: FontWeight.w600,
              color: GetColorThemeService(context).headingTextColor),
        ),
      ),
      body: ListView.separated(
          itemBuilder: ((context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: OrderCardWidget(),
            );
          }),
          separatorBuilder: ((context, index) =>
              Divider(color: GetColorThemeService(context).headingTextColor)),
          itemCount: 10),
    );
  }
}
