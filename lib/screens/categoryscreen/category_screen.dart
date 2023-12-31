// ignore_for_file: must_be_immutable

import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:daily_shop/CommonWidgets/bottom_navigation.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_data_details.dart';
import 'package:daily_shop/screens/categoryScreen/widgets/category_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = '/category';
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavigation(),
          ),
        );
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Category"),
          automaticallyImplyLeading: false,
        ),
        body: FadedSlideAnimation(
          beginOffset: const Offset(0, 0.3),
          endOffset: const Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  const VerticalSpacingWidget(height: 15),
                  GridView.builder(
                      //! category card
                      itemCount: categoryList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: .73),
                      itemBuilder: (context, index) {
                        return CategoryCardWidget(
                          image: categoryList[index]["categoryImage"],
                          title: categoryList[index]["catergoryTitle"],
                        );
                      }),
                  const VerticalSpacingWidget(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
