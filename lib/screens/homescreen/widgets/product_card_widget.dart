import 'package:daily_shop/commonwidgets/heart_icon_widget.dart';
import 'package:daily_shop/commonwidgets/horizontal_spacing_widget.dart';
import 'package:daily_shop/commonwidgets/price_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCardWidegt extends StatefulWidget {
  const ProductCardWidegt({super.key});

  @override
  State<ProductCardWidegt> createState() => _ProductCardWidegtState();
}

class _ProductCardWidegtState extends State<ProductCardWidegt> {
  final quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    quantityController.text = "1";
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () {
          print("CLICK PRODUCT CARD");
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpacingWidget(height: 10),
              Center(
                child: FancyShimmerImage(
                  imageUrl:
                      "https://freepngimg.com/download/apple_fruit/24632-1-apple-fruit-transparent.png",
                  height: 70.h,
                  width: 100.w,
                  boxFit: BoxFit.fill,
                ),
              ),
              const VerticalSpacingWidget(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Apple",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.instance.mainTextStyle(
                        fSize: 17.sp,
                        fWeight: FontWeight.w500,
                        color: GetColorThemeService(context).textColor),
                  ),
                  const HeartIconWidget(),
                ],
              ),
              PriceWidget(
                  normalPrice: 100,
                  offerPrice: 60,
                  quantity: quantityController.text,
                  isOnOffer: false),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Kg",
                    style: AppTextStyle.instance.mainTextStyle(
                        fSize: 15,
                        fWeight: FontWeight.bold,
                        color: GetColorThemeService(context).textColor),
                  ),
                  const HorizontalSpacingWidget(width: 10),
                  SizedBox(
                    height: 30.h,
                    width: 40.w,
                    child: TextFormField(
                      controller: quantityController,
                      cursorColor:
                          GetColorThemeService(context).headingTextColor,
                      keyboardType: TextInputType.number,
                      onChanged: (onValue) {
                        setState(() {
                          if (onValue.isEmpty) {
                            quantityController.text = "0";
                          }
                        });
                      },
                      style: AppTextStyle().mainTextStyle(
                          fSize: 15,
                          fWeight: FontWeight.w500,
                          color: GetColorThemeService(context).textColor),
                      maxLength: 2,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                        counterText: "",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: GetColorThemeService(context)
                                  .headingTextColor,
                              width: 0.8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: GetColorThemeService(context)
                                  .headingTextColor,
                              width: 0.8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const VerticalSpacingWidget(height: 10),
              InkWell(
                onTap: () {
                  print("CLICK ADD TO CART");
                },
                child: Container(
                  height: 30.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 0.8,
                        color: GetColorThemeService(context).headingTextColor),
                  ),
                  child: Center(
                    child: Text(
                      "ADD TO CART",
                      style: AppTextStyle().mainTextStyle(
                          fSize: 13,
                          fWeight: FontWeight.bold,
                          color:
                              GetColorThemeService(context).headingTextColor),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    quantityController.dispose();
  }
}
