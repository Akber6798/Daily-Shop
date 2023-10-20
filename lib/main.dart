// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:daily_shop/consts/firebase_consts.dart';
import 'package:daily_shop/consts/routes.dart';
import 'package:daily_shop/consts/theme_style.dart';
import 'package:daily_shop/controllers/cart_controller.dart';
import 'package:daily_shop/controllers/order_controller.dart';
import 'package:daily_shop/controllers/product_controller.dart';
import 'package:daily_shop/controllers/theme_controller.dart';
import 'package:daily_shop/controllers/viewed_recently_controller.dart';
import 'package:daily_shop/controllers/wishlist_controller.dart';
import 'package:daily_shop/screens/loadingScreen/loading_screen.dart';
import 'package:daily_shop/screens/welcomeScreen/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  //! for portrait screen only
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
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
            ChangeNotifierProvider(create: (_) => ProductController()),
            ChangeNotifierProvider(create: (_) => CartController()),
            ChangeNotifierProvider(create: (_) => WishlistController()),
            ChangeNotifierProvider(create: (_) => ViewedRecentlyController()),
            ChangeNotifierProvider(create: (_) => OrderController()),
          ],
          child: Consumer<ThemeController>(
            builder: (context, newTheme, child) {
              return MaterialApp(
                theme: ThemeStyle.themeData(newTheme.darkTheme, context),
                debugShowCheckedModeBanner: false,
                home: authenticationInstance.currentUser == null
                    ? const WelcomeScreen()
                    : const LoadingScreen(),
                routes: routes(),
              );
            },
          ),
        );
      }),
    );
  }
}
