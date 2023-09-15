import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/screens/homeScreen/widgets/offer_product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferAllProductsScreen extends StatelessWidget {
  const OfferAllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today Offer"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const VerticalSpacingWidget(height: 10),
              GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.95),
                itemBuilder: ((context, index) {
                  return OfferProductCardWidget();
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
