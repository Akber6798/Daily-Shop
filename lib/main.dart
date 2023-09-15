import 'package:daily_shop/commonwidgets/bottom_navigation.dart';
import 'package:daily_shop/consts/theme_style.dart';
import 'package:daily_shop/controllers/bottom_navigation_controller.dart';
import 'package:daily_shop/controllers/theme_controller.dart';
import 'package:daily_shop/screens/authenticationScreens/login_screen/login_screen.dart';
import 'package:daily_shop/screens/authenticationScreens/sign_up_screen/sign_up_screen.dart';
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
            ChangeNotifierProvider(
              create: (_) => BottomNavigationController(),
            ),
          ],
          child: Consumer<ThemeController>(
            builder: (context, newTheme, child) {
              return MaterialApp(
                theme: ThemeStyle.themeData(newTheme.darkTheme, context),
                debugShowCheckedModeBanner: false,
                home: LoginScreen(),
              );
            },
          ),
        );
      }),
    );
  }
}
