import 'package:daily_shop/Screens/ProfileScreen/inner_screens/edit_profile_screen.dart';
import 'package:daily_shop/screens/authenticationScreens/forget_password_screen/forget_password_screen.dart';
import 'package:daily_shop/screens/authenticationScreens/login_screen/login_screen.dart';
import 'package:daily_shop/screens/authenticationScreens/sign_up_screen/sign_up_screen.dart';
import 'package:daily_shop/screens/cartScreen/cart_screen.dart';
import 'package:daily_shop/screens/categoryScreen/category_screen.dart';
import 'package:daily_shop/screens/categoryScreen/inner_screens/category_product_screen.dart';
import 'package:daily_shop/screens/homescreen/home_screen.dart';
import 'package:daily_shop/screens/homescreen/inner_screens/all_products_screen.dart';
import 'package:daily_shop/screens/homescreen/inner_screens/offer_all_products_screen.dart';
import 'package:daily_shop/screens/homescreen/inner_screens/product_detail_screen.dart';
import 'package:daily_shop/screens/profileScreen/inner_screens/order_screen.dart';
import 'package:daily_shop/screens/profileScreen/inner_screens/viewed_recently_screen.dart';
import 'package:daily_shop/screens/profileScreen/inner_screens/wishlist_screen.dart';
import 'package:daily_shop/screens/profileScreen/profile_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes() {
  return {
    LoginScreen.routeName: (context) => const LoginScreen(),
    SignUpScreen.routeName: (context) => const SignUpScreen(),
    ForgetPasswordScreen.routeName: (context) => const ForgetPasswordScreen(),
    HomeScreen.routeName: (context) => const HomeScreen(),
    AllProductsScreen.routeName: (context) => const AllProductsScreen(),
    OfferAllProductsScreen.routeName: (context) =>
        const OfferAllProductsScreen(),
    ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
    ProfileScreen.routeName: (context) => const ProfileScreen(),
    OrderScreen.routeName: (context) => const OrderScreen(),
    ViewedRecentlyScreen.routeName: (context) => const ViewedRecentlyScreen(),
    WishlistScreen.routeName: (context) => const WishlistScreen(),
    CartScreen.routeName: (context) => const CartScreen(),
    CategoryScreen.routeName: (context) => const CategoryScreen(),
    CategoryProductScreen.routeName: (context) => const CategoryProductScreen(),
    EditProfileScreen.routeName: (context) => const EditProfileScreen(),
  };
}
