import 'package:daily_shop/commonwidgets/heart_icon_widget.dart';
import 'package:daily_shop/commonwidgets/kg_controller_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/controllers/cart_controller.dart';
import 'package:daily_shop/controllers/product_controller.dart';
import 'package:daily_shop/controllers/wishlist_controller.dart';
import 'package:daily_shop/models/cart_model.dart';
import 'package:daily_shop/screens/homescreen/inner_screens/product_detail_screen.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartCardWidget extends StatefulWidget {
  const CartCardWidget({super.key, required this.passedQuantity});

  final int passedQuantity;

  @override
  State<CartCardWidget> createState() => _CartCardWidgetState();
}

class _CartCardWidgetState extends State<CartCardWidget> {
  final quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    quantityController.text = widget.passedQuantity.toString();
  }

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);
    final cartController = Provider.of<CartController>(context);
    final wishlistController = Provider.of<WishlistController>(context);
    final cartModel = Provider.of<CartModel>(context);
    final currentProduct =
        productController.findProductById(cartModel.productId);
    double productPrice = currentProduct.isOnOffer
        ? currentProduct.offerPrice
        : currentProduct.originalPrice;
    double currentPrice = productPrice * int.parse(quantityController.text);
    bool? isInWishlist = wishlistController.getWishlistProductItems
        .containsKey(currentProduct.id);
    return GestureDetector(
      //! go to product details
      onTap: () {
        Navigator.pushNamed(context, ProductDetailScreen.routeName,
            arguments: cartModel.productId);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            //! image
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FancyShimmerImage(
                imageUrl: currentProduct.imageUrl,
                height: 60.h,
                width: 90.w,
                boxFit: BoxFit.fill,
              ),
            ),
            Column(
              children: [
                const VerticalSpacingWidget(height: 5),
                //! title
                Text(
                  currentProduct.title,
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
                              height: 30.h,
                              width: 40.w,
                              color: redColor,
                              clickedFunction: () {
                                if (quantityController.text == "1") {
                                  return;
                                } else {
                                  cartController
                                      .reduceQuantityByOne(cartModel.productId);
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
                      //! kg
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 4.w),
                          child: TextField(
                            controller: quantityController,
                            onChanged: (onValue) {
                              setState(
                                () {
                                  if (onValue.isEmpty) {
                                    quantityController.text = "1";
                                  } else {
                                    return;
                                  }
                                },
                              );
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp('[0-9]'),
                              ),
                            ],
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
                              height: 30.h,
                              width: 40.w,
                              color: greenColor,
                              clickedFunction: () {
                                cartController
                                    .increaseQuantityByOne(cartModel.productId);
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
                  //* single product remove
                  IconButton(
                    onPressed: () async {
                      await cartController.removeOneProductFromCart(
                          cartId: cartModel.id,
                          productId: cartModel.productId,
                          quantity: cartModel.quantity);
                    },
                    icon: Icon(
                      CupertinoIcons.cart_badge_minus,
                      color: redColor,
                    ),
                  ),
                  //! favourite
                  HeartIconWidget(
                    productId: currentProduct.id,
                    isInWishlist: isInWishlist,
                  ),
                  const VerticalSpacingWidget(height: 5),
                  //! total price
                  Text(
                    "₹ ${currentPrice.toStringAsFixed(2)}",
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
