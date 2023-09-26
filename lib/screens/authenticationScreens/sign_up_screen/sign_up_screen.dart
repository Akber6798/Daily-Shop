// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:daily_shop/commonwidgets/bottom_navigation.dart';
import 'package:daily_shop/commonwidgets/common_button_widget.dart';
import 'package:daily_shop/screens/authenticationScreens/widgets/loading_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/consts/firebase_consts.dart';
import 'package:daily_shop/screens/authenticationScreens/login_screen/login_screen.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:daily_shop/services/global_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final FocusNode emailFocusController = FocusNode();
  final FocusNode passwordFocusController = FocusNode();
  final FocusNode addressFocusController = FocusNode();
  final formKey = GlobalKey<FormState>();
  ValueNotifier<bool> obsecurePassword = ValueNotifier(true);
  bool isLoading = false;

  void signUp() async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });
    if (isValid) {
      formKey.currentState!.save();
      try {
        await authenticationInstance.createUserWithEmailAndPassword(
            email: emailController.text.toLowerCase().trim(),
            password: passwordController.text.trim());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((context) => BottomNavigation()),
          ),
        );
      } on FirebaseException catch (firebaseError) {
        GlobalServices.instance
            .errorDailogue(context, firebaseError.message.toString());
        log("error $firebaseError");
        setState(() {
          isLoading = false;
        });
      } catch (error) {
        GlobalServices.instance.errorDailogue(context, error.toString());
        log("error $error");
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const VerticalSpacingWidget(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome to",
                          style: AppTextStyle.instance.mainTextStyle(
                              fSize: 18,
                              fWeight: FontWeight.w400,
                              color: GetColorThemeService(context).textColor),
                        ),
                        Text(
                          "Daily Shop",
                          style: AppTextStyle.instance.mainTextStyle(
                              fSize: 25,
                              fWeight: FontWeight.w500,
                              color: GetColorThemeService(context)
                                  .headingTextColor),
                        ),
                      ],
                    ),
                    Image(
                      height: 50.h,
                      width: 50.w,
                      image: const AssetImage("assets/icons/logo.png"),
                    ),
                  ],
                ),
                const VerticalSpacingWidget(height: 30),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      //! full name
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(emailFocusController),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name is missing";
                          } else {
                            return null;
                          }
                        },
                        cursorColor:
                            GetColorThemeService(context).headingTextColor,
                        style: AppTextStyle().mainTextStyle(
                            fSize: 15,
                            fWeight: FontWeight.w500,
                            color: GetColorThemeService(context).textColor),
                        decoration: InputDecoration(
                          hintText: "Full Name",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: GetColorThemeService(context)
                                    .headingTextColor,
                                width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: GetColorThemeService(context)
                                    .headingTextColor,
                                width: 1),
                          ),
                        ),
                      ),
                      const VerticalSpacingWidget(height: 10),
                      //! email
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(passwordFocusController),
                        focusNode: emailFocusController,
                        validator: (value) {
                          if (value!.isEmpty || !value.contains("@")) {
                            return "Email is missing";
                          } else {
                            return null;
                          }
                        },
                        cursorColor:
                            GetColorThemeService(context).headingTextColor,
                        style: AppTextStyle().mainTextStyle(
                            fSize: 15,
                            fWeight: FontWeight.w500,
                            color: GetColorThemeService(context).textColor),
                        decoration: InputDecoration(
                          hintText: "Email",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: GetColorThemeService(context)
                                    .headingTextColor,
                                width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: GetColorThemeService(context)
                                    .headingTextColor,
                                width: 1),
                          ),
                        ),
                      ),
                      const VerticalSpacingWidget(height: 10),
                      //! password
                      ValueListenableBuilder(
                        valueListenable: obsecurePassword,
                        builder: ((context, value, child) {
                          return TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            focusNode: passwordFocusController,
                            obscureText: value,
                            textInputAction: TextInputAction.next,
                            cursorColor:
                                GetColorThemeService(context).headingTextColor,
                            style: AppTextStyle().mainTextStyle(
                                fSize: 15,
                                fWeight: FontWeight.w500,
                                color: GetColorThemeService(context).textColor),
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(addressFocusController),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return "Password is missing";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              suffixIcon: obsecurePassword.value
                                  ? IconButton(
                                      onPressed: () {
                                        obsecurePassword.value =
                                            !obsecurePassword.value;
                                      },
                                      icon: Icon(Icons.visibility_off_outlined,
                                          color: GetColorThemeService(context)
                                              .headingTextColor),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        obsecurePassword.value =
                                            !obsecurePassword.value;
                                      },
                                      icon: Icon(Icons.visibility_outlined,
                                          color: GetColorThemeService(context)
                                              .headingTextColor),
                                    ),
                              hintText: "Password",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: GetColorThemeService(context)
                                        .headingTextColor,
                                    width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: GetColorThemeService(context)
                                        .headingTextColor,
                                    width: 1),
                              ),
                            ),
                          );
                        }),
                      ),
                      const VerticalSpacingWidget(height: 10),
                      //! address
                      TextFormField(
                        controller: addressController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        focusNode: addressFocusController,
                        maxLines: 2,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 10) {
                            return "Address is missing";
                          } else {
                            return null;
                          }
                        },
                        cursorColor:
                            GetColorThemeService(context).headingTextColor,
                        style: AppTextStyle().mainTextStyle(
                            fSize: 15,
                            fWeight: FontWeight.w500,
                            color: GetColorThemeService(context).textColor),
                        decoration: InputDecoration(
                          hintText: "Address",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: GetColorThemeService(context)
                                    .headingTextColor,
                                width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: GetColorThemeService(context)
                                    .headingTextColor,
                                width: 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalSpacingWidget(height: 70),
                //! signup
                CommonButtonWidget(
                  height: 50,
                  width: double.infinity,
                  title: "SignUp",
                  onPressedFunction: () {
                    signUp();
                  },
                ),
                const VerticalSpacingWidget(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: AppTextStyle.instance.mainTextStyle(
                          fSize: 15,
                          fWeight: FontWeight.w400,
                          color: GetColorThemeService(context).textColor),
                    ),
                    InkWell(
                      onTap: () {
                        GlobalServices.instance.navigateTo(
                            context: context, routeName: LoginScreen.routeName);
                      },
                      child: Text(
                        "Login",
                        style: AppTextStyle.instance.mainTextStyle(
                            fSize: 16,
                            fWeight: FontWeight.w500,
                            color:
                                GetColorThemeService(context).headingTextColor),
                      ),
                    ),
                  ],
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    addressController.dispose();
    emailFocusController.dispose();
    passwordFocusController.dispose();
    addressFocusController.dispose();
  }
}
