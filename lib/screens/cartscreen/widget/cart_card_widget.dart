import 'package:daily_shop/commonwidgets/heart_icon_widget.dart';
import 'package:daily_shop/commonwidgets/kg_controller_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/consts/routes.dart';
import 'package:daily_shop/screens/homescreen/innerscreens/product_detail_screen.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartCardWidget extends StatefulWidget {
  const CartCardWidget({super.key});

  @override
  State<CartCardWidget> createState() => _CartCardWidgetState();
}

class _CartCardWidgetState extends State<CartCardWidget> {
  final quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    quantityController.text = "1";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Routes.instance.push(
          context: context,
          newScreen: const ProductDetailScreen(),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FancyShimmerImage(
                imageUrl:
                    "https://freepngimg.com/download/apple_fruit/24632-1-apple-fruit-transparent.png",
                height: 60.h,
                width: 90.w,
                boxFit: BoxFit.fill,
              ),
            ),
            Column(
              children: [
                const VerticalSpacingWidget(height: 5),
                Text(
                  "Apple",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.instance.mainTextStyle(
                      fSize: 16.sp,
                      fWeight: FontWeight.w500,
                      color: GetColorThemeService(context).textColor),
                ),
                SizedBox(
                  width: 100.w,
                  child: Row(
                    children: [
                      //! less
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: KGControllerWidget(
                              color: redColor,
                              clickedFunction: () {
                                if (quantityController.text == "1") {
                                  return;
                                } else {
                                  setState(() {
                                    quantityController.text =
                                        (int.parse(quantityController.text) - 1)
                                            .toString();
                                  });
                                }
                              },
                              icon: Icons.remove),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 4.w),
                          child: TextField(
                            controller: quantityController,
                            onChanged: (onValue) {
                              setState(() {
                                if (onValue.isEmpty) {
                                  quantityController.text = "0";
                                }
                              });
                            },
                            cursorColor:
                                GetColorThemeService(context).headingTextColor,
                            keyboardType: TextInputType.number,
                            style: AppTextStyle().mainTextStyle(
                                fSize: 15,
                                fWeight: FontWeight.w500,
                                color: GetColorThemeService(context).textColor),
                          ),
                        ),
                      ),
                      //! add
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: KGControllerWidget(
                              color: greenColor,
                              clickedFunction: () {
                                setState(() {
                                  quantityController.text =
                                      (int.parse(quantityController.text) + 1)
                                          .toString();
                                });
                              },
                              icon: Icons.add),
                        ),
                      )
                    ],
                  ),
                ),
                const VerticalSpacingWidget(height: 5),
              ],
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5.h, 10.w, 5.h),
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.cart_badge_minus,
                      color: redColor,
                    ),
                  ),
                  HeartIconWidget(
                    iconColor: greenColor,
                  ),
                  const VerticalSpacingWidget(height: 5),
                  Text(
                    "₹ 100",
                    style: AppTextStyle.instance.mainTextStyle(
                        fSize: 14.sp,
                        fWeight: FontWeight.w500,
                        color: GetColorThemeService(context).textColor),
                    maxLines: 1,
                  )
                ],
              ),
            )
          ],
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
