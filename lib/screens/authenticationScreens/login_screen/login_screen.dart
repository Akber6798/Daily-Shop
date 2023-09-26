// ignore_for_file: use_build_context_synchronously

import 'package:daily_shop/commonwidgets/bottom_navigation.dart';
import 'package:daily_shop/commonwidgets/common_button_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/consts/firebase_consts.dart';
import 'package:daily_shop/screens/authenticationScreens/forget_password_screen/forget_password_screen.dart';
import 'package:daily_shop/screens/authenticationScreens/sign_up_screen/sign_up_screen.dart';
import 'package:daily_shop/screens/authenticationScreens/widgets/loading_widget.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:daily_shop/services/global_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusController = FocusNode();
  final formKey = GlobalKey<FormState>();
  ValueNotifier<bool> obsecurePassword = ValueNotifier(true);
  bool isLoading = false;

  //* login with email and password
  Future<void> login() async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });
    if (isValid) {
      formKey.currentState!.save();
      try {
        await authenticationInstance.signInWithEmailAndPassword(
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const VerticalSpacingWidget(height: 45),
              //! heading section
              Text(
                "Welcome Back",
                style: AppTextStyle.instance.mainTextStyle(
                    fSize: 30,
                    fWeight: FontWeight.w500,
                    color: GetColorThemeService(context).headingTextColor),
              ),
              Text(
                "Login to continue",
                style: AppTextStyle.instance.mainTextStyle(
                    fSize: 18,
                    fWeight: FontWeight.w400,
                    color: GetColorThemeService(context).textColor),
              ),
              const VerticalSpacingWidget(height: 45),
              Align(
                alignment: Alignment.center,
                child: Image(
                  height: 125.h,
                  width: 125.w,
                  image: const AssetImage("assets/icons/logo.png"),
                ),
              ),
              const VerticalSpacingWidget(height: 35),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    //! email
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(passwordFocusController),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains("@")) {
                          return "Please enter the valid email address";
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
                          cursorColor:
                              GetColorThemeService(context).headingTextColor,
                          style: AppTextStyle().mainTextStyle(
                              fSize: 15,
                              fWeight: FontWeight.w500,
                              color: GetColorThemeService(context).textColor),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return "Please enter valid password";
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
                  ],
                ),
              ),
              const VerticalSpacingWidget(height: 5),
              //! forget password
              InkWell(
                onTap: () {
                  GlobalServices.instance.navigateTo(
                      context: context,
                      routeName: ForgetPasswordScreen.routeName);
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forget password",
                    style: AppTextStyle.instance.mainTextStyle(
                        fSize: 14,
                        fWeight: FontWeight.bold,
                        color: GetColorThemeService(context).headingTextColor),
                  ),
                ),
              ),
              const VerticalSpacingWidget(height: 20),
              //! login
              CommonButtonWidget(
                height: 50,
                width: double.infinity,
                title: "Login",
                onPressedFunction: () {
                  login();
                },
              ),
              const VerticalSpacingWidget(height: 20),
              //! guest
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => BottomNavigation()),
                    ),
                  );
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Continue as guest",
                    style: AppTextStyle.instance.mainTextStyle(
                        fSize: 14, fWeight: FontWeight.w500, color: redColor),
                  ),
                ),
              ),
              const VerticalSpacingWidget(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: AppTextStyle.instance.mainTextStyle(
                        fSize: 15,
                        fWeight: FontWeight.w400,
                        color: GetColorThemeService(context).textColor),
                  ),
                  //! sign up
                  InkWell(
                    onTap: () {
                      GlobalServices.instance.navigateTo(
                          context: context, routeName: SignUpScreen.routeName);
                    },
                    child: Text(
                      "Sign up",
                      style: AppTextStyle.instance.mainTextStyle(
                          fSize: 16,
                          fWeight: FontWeight.w500,
                          color:
                              GetColorThemeService(context).headingTextColor),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordFocusController.dispose();
  }
}
