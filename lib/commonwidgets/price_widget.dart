import 'package:daily_shop/commonwidgets/horizontal_spacing_widget.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget(
      {super.key,
      required this.normalPrice,
      required this.offerPrice,
      required this.quantity,
      required this.isOnOffer});

  final double normalPrice;
  final double offerPrice;
  final String quantity;
  final bool isOnOffer;

  @override
  Widget build(BuildContext context) {
    double productPrice = isOnOffer ? offerPrice : normalPrice;
    return FittedBox(
      child: Row(
        children: [
          Text(
            "₹${(productPrice * int.parse(quantity)).toStringAsFixed(2)}",
            style: AppTextStyle.instance.mainTextStyle(
                fSize: 16.sp,
                fWeight: FontWeight.bold,
                color: GetColorThemeService(context).headingTextColor),
          ),
          const HorizontalSpacingWidget(width: 5),
          Visibility(
            visible: isOnOffer ? true : false,
            child: Text(
              "₹${(normalPrice * int.parse(quantity)).toStringAsFixed(2)}",
              style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.lineThrough),
            ),
          ),
        ],
      ),
    );
  }
}
