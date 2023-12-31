import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:daily_shop/commonwidgets/empty_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/controllers/product_controller.dart';
import 'package:daily_shop/models/product_model.dart';
import 'package:daily_shop/screens/homeScreen/widgets/offer_product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OfferAllProductsScreen extends StatelessWidget {
  static const routeName = '/offerAllProducts';
  const OfferAllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);
    List<ProductModel> offerAllProducts = productController.getOfferProductList;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today Offer"),
      ),
      body: offerAllProducts.isEmpty
          ? const EmptyWidget(
              emptyAnimation: "assets/animations/empty_products.json",
              emptyTitle: "No Products are available")
          : FadedSlideAnimation(
              beginOffset: const Offset(0, 0.3),
              endOffset: const Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const VerticalSpacingWidget(height: 10),
                      //! offer card
                      GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: offerAllProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 0.88),
                        itemBuilder: ((context, index) {
                          return ChangeNotifierProvider.value(
                            value: offerAllProducts[index],
                            child: const OfferProductCardWidget(),
                          );
                        }),
                      ),
                      const VerticalSpacingWidget(height: 10)
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
