// ignore_for_file: must_be_immutable

import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_data_details.dart';
import 'package:daily_shop/screens/categoryScreen/widgets/category_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryScreen extends StatelessWidget {
 const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              const VerticalSpacingWidget(height: 15),
              GridView.builder(
                  itemCount: categoryList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 7,
                      childAspectRatio: .79),
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
    );
  }
}
