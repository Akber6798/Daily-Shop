// ignore_for_file: use_build_context_synchronously

import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/consts/firebase_consts.dart';
import 'package:daily_shop/controllers/theme_controller.dart';
import 'package:daily_shop/screens/authenticationScreens/forget_password_screen/forget_password_screen.dart';
import 'package:daily_shop/screens/authenticationScreens/login_screen/login_screen.dart';
import 'package:daily_shop/screens/profileScreen/inner_screens/order_screen.dart';
import 'package:daily_shop/screens/profileScreen/inner_screens/viewed_recently_screen.dart';
import 'package:daily_shop/screens/profileScreen/inner_screens/wishlist_screen.dart';
import 'package:daily_shop/screens/profileScreen/widgets/list_tile_widget.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:daily_shop/services/global_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _addressController = TextEditingController();
  final User? user = authenticationInstance.currentUser;
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalSpacingWidget(height: 10.h),
            //! name
            Text(
              "Akber A A",
              style: AppTextStyle.instance.mainTextStyle(
                  fSize: 22,
                  fWeight: FontWeight.w600,
                  color: GetColorThemeService(context).headingTextColor),
            ),
            //! email
            Text(
              "akber.a.azad@gmail.com",
              style: AppTextStyle.instance.mainTextStyle(
                  fSize: 16,
                  fWeight: FontWeight.w400,
                  color: GetColorThemeService(context).textColor),
            ),
            VerticalSpacingWidget(height: 10.h),
            Divider(
              thickness: 4,
              color: Theme.of(context).cardColor,
            ),
            VerticalSpacingWidget(height: 20.h),
            ListTileWidget(
              title: "Address",
              icon: IconlyLight.home,
              onPressed: () {
                addAddress();
              },
            ),
            ListTileWidget(
              title: "Orders",
              icon: IconlyLight.bag,
              onPressed: () {
                GlobalServices.instance.navigateTo(
                    context: context, routeName: OrderScreen.routeName);
              },
            ),
            ListTileWidget(
              title: "Whislist",
              icon: IconlyLight.heart,
              onPressed: () {
                GlobalServices.instance.navigateTo(
                    context: context, routeName: WishlistScreen.routeName);
              },
            ),
            ListTileWidget(
              title: "Viewed",
              icon: IconlyLight.show,
              onPressed: () {
                if (user == null) {
                  GlobalServices.instance
                      .errorDailogue(context, "No user found \nPlease login..");
                  return;
                }
                GlobalServices.instance.navigateTo(
                    context: context,
                    routeName: ViewedRecentlyScreen.routeName);
              },
            ),
            ListTileWidget(
              title: "Forgot Password",
              icon: IconlyLight.unlock,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgetPasswordScreen(),
                  ),
                );
              },
            ),
            SwitchListTile(
                title: Text(
                  "Dark Mode",
                  style: AppTextStyle.instance.mainTextStyle(
                      fSize: 19,
                      fWeight: FontWeight.w400,
                      color: GetColorThemeService(context).textColor),
                ),
                secondary: Icon(
                  themeState.darkTheme
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                  color: Theme.of(context).iconTheme.color,
                ),
                value: themeState.darkTheme,
                onChanged: (value) {
                  themeState.setDarkTheme = value;
                }),
            ListTileWidget(
              title: user == null ? "Login" : "Logout",
              icon: IconlyLight.logout,
              onPressed: () {
                user == null
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      )
                    : GlobalServices.instance.closingDailogue(
                        context, "Sign Out", "Do you wanna Sign Out?",
                        () async {
                        await authenticationInstance.signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      });
              },
            ),
            const VerticalSpacingWidget(height: 30),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Version : 1.0",
                style: AppTextStyle.instance.mainTextStyle(
                    fSize: 18, fWeight: FontWeight.w500, color: redColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  //* add address
  addAddress() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: ((context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            "Update Adderss",
            style: AppTextStyle.instance.mainTextStyle(
                fSize: 21,
                fWeight: FontWeight.bold,
                color: GetColorThemeService(context).headingTextColor),
          ),
          content: TextFormField(
            cursorColor: GetColorThemeService(context).headingTextColor,
            controller: _addressController,
            maxLines: 4,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: GetColorThemeService(context).headingTextColor,
                    width: 1.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: GetColorThemeService(context).headingTextColor,
                    width: 1.w),
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "No",
                style: AppTextStyle.instance.mainTextStyle(
                    fSize: 16,
                    fWeight: FontWeight.w800,
                    color: GetColorThemeService(context).headingTextColor),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Update",
                style: AppTextStyle.instance.mainTextStyle(
                    fSize: 18, fWeight: FontWeight.bold, color: redColor),
              ),
            )
          ],
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _addressController.dispose();
  }
}
