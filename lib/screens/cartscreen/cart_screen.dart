import 'package:daily_shop/commonwidgets/common_button_widget.dart';
import 'package:daily_shop/commonwidgets/empty_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/controllers/cart_controller.dart';
import 'package:daily_shop/controllers/product_controller.dart';
import 'package:daily_shop/screens/cartScreen/widget/cart_card_widget.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:daily_shop/services/global_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context);
    final cartProductList =
        cartController.getCartProductItems.values.toList().reversed.toList();
    final productController = Provider.of<ProductController>(context);
    double totalPrice = 0.0;
    cartController.getCartProductItems.forEach((key, value) {
      final currentProdcut = productController.findProductById(value.productId);
      totalPrice += (currentProdcut.isOnOffer
              ? currentProdcut.offerPrice
              : currentProdcut.originalPrice) *
          value.quantity;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          cartProductList.isEmpty ? "Cart" : "Cart (${cartProductList.length})",
          style: AppTextStyle.instance.mainTextStyle(
              fSize: 20.sp,
              fWeight: FontWeight.w600,
              color: GetColorThemeService(context).headingTextColor),
        ),
        centerTitle: false,
        actions: [
          //* to clear the cart
          IconButton(
            onPressed: () {
              GlobalServices.instance.closingDailogue(
                context,
                "Delete cart",
                "Do you want to delete all?",
                () async {
                  await cartController.clearAllCartItems();
                },
              );
            },
            icon: Icon(IconlyLight.delete, color: redColor),
          )
        ],
      ),
      body: cartProductList.isEmpty
          ? const EmptyWidget(
              emptyAnimation: "assets/animations/empty_cart.json",
              emptyTitle: "No products on your cart \n start shopping")
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                children: [
                  const VerticalSpacingWidget(height: 5),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //! for order
                        CommonButtonWidget(
                            height: 40,
                            width: 100,
                            title: "Order Now",
                            onPressedFunction: () {}),
                        FittedBox(
                          //! total price
                          child: Text(
                            "Total: ₹ ${totalPrice.toStringAsFixed(2)}",
                            style: AppTextStyle.instance.mainTextStyle(
                                fSize: 16.sp,
                                fWeight: FontWeight.w500,
                                color: GetColorThemeService(context).textColor),
                          ),
                        )
                      ],
                    ),
                  ),
                  const VerticalSpacingWidget(height: 10),
                  //! cart card
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartProductList.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: ChangeNotifierProvider.value(
                            value: cartProductList[index],
                            child: CartCardWidget(
                              passedQuantity: cartProductList[index].quantity,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
