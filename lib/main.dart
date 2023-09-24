import 'package:daily_shop/commonwidgets/bottom_navigation.dart';
import 'package:daily_shop/consts/theme_style.dart';
import 'package:daily_shop/controllers/bottom_navigation_controller.dart';
import 'package:daily_shop/controllers/cart_controller.dart';
import 'package:daily_shop/controllers/product_controller.dart';
import 'package:daily_shop/controllers/theme_controller.dart';
import 'package:daily_shop/controllers/viewed_recently_controller.dart';
import 'package:daily_shop/controllers/wishlist_controller.dart';
import 'package:daily_shop/screens/authenticationScreens/forget_password_screen/forget_password_screen.dart';
import 'package:daily_shop/screens/authenticationScreens/login_screen/login_screen.dart';
import 'package:daily_shop/screens/authenticationScreens/sign_up_screen/sign_up_screen.dart';
import 'package:daily_shop/screens/cartScreen/cart_screen.dart';
import 'package:daily_shop/screens/categoryScreen/category_screen.dart';
import 'package:daily_shop/screens/categoryScreen/inner_screens/category_product_screen.dart';
import 'package:daily_shop/screens/homeScreen/home_screen.dart';
import 'package:daily_shop/screens/homescreen/inner_screens/all_products_screen.dart';
import 'package:daily_shop/screens/homescreen/inner_screens/offer_all_products_screen.dart';
import 'package:daily_shop/screens/homescreen/inner_screens/product_detail_screen.dart';
import 'package:daily_shop/screens/profileScreen/inner_screens/order_screen.dart';
import 'package:daily_shop/screens/profileScreen/inner_screens/viewed_recently_screen.dart';
import 'package:daily_shop/screens/profileScreen/inner_screens/wishlist_screen.dart';
import 'package:daily_shop/screens/profileScreen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeController themeController = ThemeController();

//* get current theme
  void getCurrentAppTheme() async {
    themeController.setDarkTheme =
        await themeController.themeService.getTheme();
  }

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: ((context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => themeController),
            ChangeNotifierProvider(create: (_) => BottomNavigationController()),
            ChangeNotifierProvider(create: (_) => ProductController()),
            ChangeNotifierProvider(create: (_) => CartController()),
            ChangeNotifierProvider(create: (_) => WishlistController()),
            ChangeNotifierProvider(create: (_) => ViewedRecentlyController()),
          ],
          child: Consumer<ThemeController>(
            builder: (context, newTheme, child) {
              return MaterialApp(
                theme: ThemeStyle.themeData(newTheme.darkTheme, context),
                debugShowCheckedModeBanner: false,
                home: BottomNavigation(),
                routes: {
                  LoginScreen.routeName: (context) => const LoginScreen(),
                  SignUpScreen.routeName: (context) => const SignUpScreen(),
                  ForgetPasswordScreen.routeName: (context) =>
                      const ForgetPasswordScreen(),
                  HomeScreen.routeName: (context) => const HomeScreen(),
                  AllProductsScreen.routeName: (context) =>
                      const AllProductsScreen(),
                  OfferAllProductsScreen.routeName: (context) =>
                      const OfferAllProductsScreen(),
                  ProductDetailScreen.routeName: (context) =>
                      const ProductDetailScreen(),
                  ProfileScreen.routeName: (context) => const ProfileScreen(),
                  OrderScreen.routeName: (context) => const OrderScreen(),
                  ViewedRecentlyScreen.routeName: (context) => const ViewedRecentlyScreen(),
                  WishlistScreen.routeName: (context) => const WishlistScreen(),
                  CartScreen.routeName: (context) => const CartScreen(),
                  CategoryScreen.routeName: (context) => const CategoryScreen(),
                  CategoryProductScreen.routeName: (context) =>
                      const CategoryProductScreen(),
                },
              );
            },
          ),
        );
      }),
    );
  }
}
