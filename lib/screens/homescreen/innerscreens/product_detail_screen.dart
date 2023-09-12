import 'package:daily_shop/commonwidgets/common_button.dart';
import 'package:daily_shop/commonwidgets/heart_icon_widget.dart';
import 'package:daily_shop/commonwidgets/horizontal_spacing_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final quantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Flexible(
          flex: 3,
          child: Center(
            child: FancyShimmerImage(
                imageUrl:
                    "https://freepngimg.com/download/apple_fruit/24632-1-apple-fruit-transparent.png",
                height: 140.h,
                width: 210.w,
                boxFit: BoxFit.fill),
          ),
        ),
        Flexible(
          flex: 4,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  const VerticalSpacingWidget(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Title",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.instance.mainTextStyle(
                            fSize: 18.sp,
                            fWeight: FontWeight.w600,
                            color: GetColorThemeService(context).textColor),
                      ),
                      HeartIconWidget(iconColor: redColor),
                    ],
                  ),
                  const VerticalSpacingWidget(height: 20),
                  Row(
                    children: [
                      Text(
                        "₹60",
                        style: AppTextStyle.instance.mainTextStyle(
                            fSize: 22.sp,
                            fWeight: FontWeight.bold,
                            color:
                                GetColorThemeService(context).headingTextColor),
                      ),
                      Text(
                        " Kg",
                        style: AppTextStyle.instance.mainTextStyle(
                            fSize: 18,
                            fWeight: FontWeight.w600,
                            color: GetColorThemeService(context).textColor),
                      ),
                      const HorizontalSpacingWidget(width: 5),
                      Visibility(
                        visible: true,
                        child: Text(
                          "100",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 35.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          color: GetColorThemeService(context).headingTextColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Free Delivery",
                            style: AppTextStyle.instance.mainTextStyle(
                                fSize: 14.sp,
                                fWeight: FontWeight.w500,
                                color: whiteColor),
                          ),
                        ),
                      )
                    ],
                  ),
                  const VerticalSpacingWidget(height: 30),
                  SizedBox(
                    width: 150.w,
                    child: Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Material(
                              color: redColor,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {},
                                child: Icon(
                                  Icons.remove,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 4.w),
                            child: TextField(
                              controller: quantityController,
                              cursorColor: GetColorThemeService(context)
                                  .headingTextColor,
                              keyboardType: TextInputType.number,
                              style: AppTextStyle().mainTextStyle(
                                  fSize: 15,
                                  fWeight: FontWeight.w500,
                                  color:
                                      GetColorThemeService(context).textColor),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Material(
                              color: greenColor,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {},
                                child: Icon(
                                  Icons.add,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Divider(
                    color: GetColorThemeService(context).headingTextColor,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total",
                            style: AppTextStyle.instance.mainTextStyle(
                                fSize: 18.sp,
                                fWeight: FontWeight.bold,
                                color: redColor),
                          ),
                          Row(
                            children: [
                              Text(
                                "₹60",
                                style: AppTextStyle.instance.mainTextStyle(
                                    fSize: 17.sp,
                                    fWeight: FontWeight.bold,
                                    color: GetColorThemeService(context)
                                        .headingTextColor),
                              ),
                              Text(
                                " Kg",
                                style: AppTextStyle.instance.mainTextStyle(
                                    fSize: 14,
                                    fWeight: FontWeight.w500,
                                    color: GetColorThemeService(context)
                                        .textColor),
                              ),
                            ],
                          ),
                          const VerticalSpacingWidget(height: 10)
                        ],
                      ),
                      CommonButton(
                          height: 40,
                          width: 100,
                          title: "Add to cart",
                          onPressedFunction: () {})
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    quantityController.dispose();
  }
}
