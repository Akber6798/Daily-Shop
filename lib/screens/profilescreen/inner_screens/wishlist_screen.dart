import 'package:daily_shop/commonwidgets/empty_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/controllers/wishlist_controller.dart';
import 'package:daily_shop/screens/profileScreen/widgets/wishlist_card_widget.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:daily_shop/services/global_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/whislist';
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistController = Provider.of<WishlistController>(context);
    final wishlistProductList = wishlistController
        .getWishlistProductItems.values
        .toList()
        .reversed
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          wishlistProductList.isEmpty
              ? "Wishlist"
              : "Wishlist (${wishlistProductList.length})",
          style: AppTextStyle.instance.mainTextStyle(
              fSize: 20.sp,
              fWeight: FontWeight.w600,
              color: GetColorThemeService(context).headingTextColor),
        ),
        actions: [
          IconButton(
            onPressed: () {
              GlobalServices.instance.closingDailogue(
                context,
                "Delete wishlist",
                "Do you want to delete all?",
                () {
                  wishlistController.clearAllWishlistItems();
                },
              );
            },
            icon: Icon(IconlyLight.delete, color: redColor),
          )
        ],
      ),
      body: wishlistProductList.isEmpty
          ? const EmptyWidget(
              emptyAnimation: "assets/animations/empty_wishlist.json",
              emptyTitle: "No products on your\n Wishlist")
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  children: [
                    const VerticalSpacingWidget(height: 15),
                    GridView.builder(
                        itemCount: wishlistProductList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 7,
                                mainAxisSpacing: 7,
                                childAspectRatio: .95),
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                            value: wishlistProductList[index],
                            child: const WishlistCardWidget(),
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
