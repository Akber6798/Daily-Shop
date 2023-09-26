import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/firebase_consts.dart';
import 'package:daily_shop/controllers/wishlist_controller.dart';
import 'package:daily_shop/services/global_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HeartIconWidget extends StatelessWidget {
  const HeartIconWidget(
      {super.key, required this.productId, this.isInWishlist = false});
  final String productId;
  final bool? isInWishlist;

  @override
  Widget build(BuildContext context) {
    final wishlistController = Provider.of<WishlistController>(context);
    final User? user = authenticationInstance.currentUser;
    return GestureDetector(
      onTap: () {
        if (user == null) {
          GlobalServices.instance
              .errorDailogue(context, "No user found \nPlease login..");
          return;
        }
        wishlistController.addAndRemoveProductToWishlist(productId: productId);
      },
      child: Icon(
        isInWishlist != null && isInWishlist == true
            ? IconlyBold.heart
            : IconlyLight.heart,
        size: 21.sp,
        color: redColor,
      ),
    );
  }
}
