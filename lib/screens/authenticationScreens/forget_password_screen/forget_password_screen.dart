// ignore_for_file: use_build_context_synchronously

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:daily_shop/commonwidgets/common_button_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/consts/firebase_consts.dart';
import 'package:daily_shop/commonwidgets/loading_widget.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:daily_shop/services/global_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = '/forgetPassword';
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  //* to reset the password
  Future<void> forgetPassword() async {
    if (emailController.text.isEmpty || !emailController.text.contains("@")) {
      GlobalServices.instance
          .errorDailogue(context, "Please enter the correct email");
    } else {
      setState(() {
        isLoading = true;
      });
      try {
        await authenticationInstance.sendPasswordResetEmail(
          email: emailController.text.toLowerCase(),
        );
        GlobalServices.instance
            .showToastMessage("An email has been sent your email address");
      } on FirebaseException catch (firebaseError) {
        GlobalServices.instance
            .errorDailogue(context, firebaseError.message.toString());
        setState(() {
          isLoading = false;
        });
      } catch (error) {
        GlobalServices.instance.errorDailogue(context, error.toString());
        setState(() {
          isLoading = false;
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadinWidget(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(),
        body: FadedSlideAnimation(
          beginOffset: const Offset(0, 0.3),
          endOffset: const Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
          child: Padding(
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
                          color:
                              GetColorThemeService(context).headingTextColor),
                    ),
                    FadedScaleAnimation(
                      scaleDuration: const Duration(milliseconds: 400),
                      fadeDuration: const Duration(milliseconds: 400),
                      child: Image(
                        height: 40.h,
                        width: 40.w,
                        image: const AssetImage("assets/icons/logo.png"),
                      ),
                    ),
                  ],
                ),
                const VerticalSpacingWidget(height: 50),
                //! email
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
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
                  onPressedFunction: () {
                    forgetPassword();
                  },
                ),
              ],
            ),
          ),
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
