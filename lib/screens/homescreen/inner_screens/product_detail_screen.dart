import 'package:daily_shop/commonwidgets/common_button_widget.dart';
import 'package:daily_shop/commonwidgets/heart_icon_widget.dart';
import 'package:daily_shop/commonwidgets/horizontal_spacing_widget.dart';
import 'package:daily_shop/commonwidgets/kg_controller_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/consts/firebase_consts.dart';
import 'package:daily_shop/controllers/cart_controller.dart';
import 'package:daily_shop/controllers/product_controller.dart';
import 'package:daily_shop/controllers/viewed_recently_controller.dart';
import 'package:daily_shop/controllers/wishlist_controller.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:daily_shop/services/global_services.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/productDetail';
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    quantityController.text = "1";
  }

  @override
  Widget build(BuildContext context) {
    final User? user = authenticationInstance.currentUser;
    final productController = Provider.of<ProductController>(context);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final currentProduct = productController.findProductById(productId);
    final cartController = Provider.of<CartController>(context);
    final wishlistController = Provider.of<WishlistController>(context);
    final viewedRecentlyController =
        Provider.of<ViewedRecentlyController>(context);
    double productPrice = currentProduct.isOnOffer
        ? currentProduct.offerPrice
        : currentProduct.originalPrice;
    double totalPrice = productPrice * int.parse(quantityController.text);
    bool isInCart =
        cartController.getCartProductItems.containsKey(currentProduct.id);
    bool? isInWishlist = wishlistController.getWishlistProductItems
        .containsKey(currentProduct.id);
    return WillPopScope(
      //! to add recently viewed list
      onWillPop: () async {
        viewedRecentlyController.addProductToRecentlyViewed(
            productId: productId);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          Flexible(
            flex: 3,
            child: Center(
              //! image
              child: FancyShimmerImage(
                  imageUrl: currentProduct.imageUrl,
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
                        //! title
                        Text(
                          currentProduct.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.instance.mainTextStyle(
                              fSize: 18.sp,
                              fWeight: FontWeight.w600,
                              color: GetColorThemeService(context).textColor),
                        ),
                        //! favourite
                        HeartIconWidget(
                          productId: currentProduct.id,
                          isInWishlist: isInWishlist,
                        ),
                      ],
                    ),
                    const VerticalSpacingWidget(height: 20),
                    Row(
                      children: [
                        //! price
                        Text(
                          "₹${productPrice.toStringAsFixed(2)}",
                          style: AppTextStyle.instance.mainTextStyle(
                              fSize: 22.sp,
                              fWeight: FontWeight.bold,
                              color: GetColorThemeService(context)
                                  .headingTextColor),
                        ),
                        Text(
                          currentProduct.isPiece ? " /Piece" : " /Kg",
                          style: AppTextStyle.instance.mainTextStyle(
                              fSize: 18,
                              fWeight: FontWeight.w600,
                              color: GetColorThemeService(context).textColor),
                        ),
                        const HorizontalSpacingWidget(width: 5),
                        Visibility(
                          visible: currentProduct.isOnOffer ? true : false,
                          child: Text(
                            currentProduct.originalPrice.toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "Free Delivery",
                          style: AppTextStyle.instance.mainTextStyle(
                              fSize: 18.sp,
                              fWeight: FontWeight.w500,
                              color: GetColorThemeService(context)
                                  .headingTextColor),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              //! less
                              child: KGControllerWidget(
                                  color: redColor,
                                  clickedFunction: () {
                                    if (quantityController.text == "1") {
                                      return;
                                    } else {
                                      setState(() {
                                        quantityController.text = (int.parse(
                                                    quantityController.text) -
                                                1)
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
                                  setState(() {
                                    if (onValue.isEmpty) {
                                      quantityController.text = "1";
                                    } else {
                                      return;
                                    }
                                  });
                                },
                                cursorColor: GetColorThemeService(context)
                                    .headingTextColor,
                                keyboardType: TextInputType.number,
                                style: AppTextStyle().mainTextStyle(
                                    fSize: 15,
                                    fWeight: FontWeight.w500,
                                    color: GetColorThemeService(context)
                                        .textColor),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              //! add
                              child: KGControllerWidget(
                                  color: greenColor,
                                  clickedFunction: () {
                                    setState(() {
                                      quantityController.text =
                                          (int.parse(quantityController.text) +
                                                  1)
                                              .toString();
                                    });
                                  },
                                  icon: Icons.add),
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
                    //! total
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
                                  "₹${totalPrice.toStringAsFixed(2)}",
                                  style: AppTextStyle.instance.mainTextStyle(
                                      fSize: 17.sp,
                                      fWeight: FontWeight.bold,
                                      color: GetColorThemeService(context)
                                          .headingTextColor),
                                ),
                                Text(
                                  " /${quantityController.text}Kg",
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
                        //! add to cart
                        CommonButtonWidget(
                          height: 40,
                          width: 100,
                          title: isInCart ? "In cart" : "Add to cart",
                          onPressedFunction: isInCart
                              ? null
                              : () {
                                  if (user == null) {
                                    GlobalServices.instance.errorDailogue(
                                        context,
                                        "No user found \nPlease login..");
                                    return;
                                  }
                                  cartController.addProductToCart(
                                    productId: currentProduct.id,
                                    quantity:
                                        int.parse(quantityController.text),
                                  );
                                },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    quantityController.dispose();
  }
}
