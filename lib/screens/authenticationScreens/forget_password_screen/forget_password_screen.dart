import 'package:daily_shop/commonwidgets/common_button_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          children: [
            const VerticalSpacingWidget(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Forget Password",
                  style: AppTextStyle.instance.mainTextStyle(
                      fSize: 22,
                      fWeight: FontWeight.w600,
                      color: GetColorThemeService(context).headingTextColor),
                ),
                Image(
                  height: 40.h,
                  width: 40.w,
                  image: const AssetImage("assets/icons/logo.png"),
                ),
              ],
            ),
            const VerticalSpacingWidget(height: 50),
            //! email
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value!.isEmpty || !value.contains("@")) {
                  return "Please enter the valid email address";
                } else {
                  return null;
                }
              },
              cursorColor: GetColorThemeService(context).headingTextColor,
              style: AppTextStyle().mainTextStyle(
                  fSize: 15,
                  fWeight: FontWeight.w500,
                  color: GetColorThemeService(context).textColor),
              decoration: InputDecoration(
                hintText: "Email",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: GetColorThemeService(context).headingTextColor,
                      width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: GetColorThemeService(context).headingTextColor,
                      width: 1),
                ),
              ),
            ),
            const VerticalSpacingWidget(height: 30),
            CommonButtonWidget(
              height: 50,
              width: double.infinity,
              title: "Reset Now",
              onPressedFunction: () {},
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }
}
