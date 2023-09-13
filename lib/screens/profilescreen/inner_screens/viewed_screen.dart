import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/screens/profilescreen/widgets/viewed_card_widget.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:daily_shop/services/global_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewedScreen extends StatelessWidget {
  const ViewedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Viewed Recently",
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
      body: ListView.builder(
          itemBuilder: ((context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
              child: ViewedCardWidget(),
            );
          }),
          itemCount: 10),
    );
  }
}
