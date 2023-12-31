// ignore_for_file: use_build_context_synchronously

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_shop/commonwidgets/common_button_widget.dart';
import 'package:daily_shop/commonwidgets/loading_widget.dart';
import 'package:daily_shop/commonwidgets/vertical_spacing_widget.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/consts/firebase_consts.dart';
import 'package:daily_shop/screens/authenticationScreens/login_screen/login_screen.dart';
import 'package:daily_shop/screens/loadingScreen/loading_screen.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:daily_shop/services/global_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController houseNameController = TextEditingController();
  final TextEditingController streetNameConroller = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final FocusNode emailFocusController = FocusNode();
  final FocusNode passwordFocusController = FocusNode();
  final FocusNode phoneNumberFocusController = FocusNode();
  final FocusNode houserNameFocusController = FocusNode();
  final FocusNode streetNameFocusController = FocusNode();
  final FocusNode pincodeFocusController = FocusNode();
  final formKey = GlobalKey<FormState>();
  ValueNotifier<bool> obsecurePassword = ValueNotifier(true);
  bool isLoading = false;

  //! sign up
  void signUp() async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      try {
        await authenticationInstance.createUserWithEmailAndPassword(
            email: emailController.text.toLowerCase().trim(),
            password: passwordController.text.trim());
        //* store details to firestore
        final User? user = authenticationInstance.currentUser;
        final userId = user!.uid;
        user.updateDisplayName(nameController.text);
        user.reload();
        await FirebaseFirestore.instance
            .collection("userDetails")
            .doc(userId)
            .set({
          'id': userId,
          'name': nameController.text,
          'email': emailController.text,
          'phoneNumber': phoneNumberController.text,
          'houseName': houseNameController.text,
          'streetName': streetNameConroller.text,
          'pincode': pincodeController.text,
          'userWishlist': [],
          'userCartList': [],
          'createdAt': Timestamp.now()
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((context) => const LoadingScreen()),
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
        appBar: AppBar(),
        body: FadedSlideAnimation(
          beginOffset: const Offset(0, 0.3),
          endOffset: const Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //! welcome text
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
                      FadedScaleAnimation(
                        scaleDuration: const Duration(milliseconds: 400),
                        fadeDuration: const Duration(milliseconds: 400),
                        child: Image(
                          height: 50.h,
                          width: 50.w,
                          image: const AssetImage("assets/icons/logo.png"),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpacingWidget(height: 5),
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
                        const VerticalSpacingWidget(height: 5),
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
                        const VerticalSpacingWidget(height: 5),
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
                              cursorColor: GetColorThemeService(context)
                                  .headingTextColor,
                              style: AppTextStyle().mainTextStyle(
                                  fSize: 15,
                                  fWeight: FontWeight.w500,
                                  color:
                                      GetColorThemeService(context).textColor),
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(phoneNumberFocusController),
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
                                        icon: Icon(
                                            Icons.visibility_off_outlined,
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
                        const VerticalSpacingWidget(height: 5),
                        //! phone number
                        TextFormField(
                          controller: phoneNumberController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          focusNode: phoneNumberFocusController,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(houserNameFocusController),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 10) {
                              return "Phone number is missing";
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
                            hintText: "Phone Number",
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
                        const VerticalSpacingWidget(height: 5),
                        //! house name
                        TextFormField(
                          controller: houseNameController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          focusNode: houserNameFocusController,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(streetNameFocusController),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 10) {
                              return "House name is missing";
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
                            hintText: "House Name",
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
                  VerticalSpacingWidget(height: 5),
                  //! street name
                  TextFormField(
                    controller: streetNameConroller,
                    keyboardType: TextInputType.name,
                    focusNode: streetNameFocusController,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context)
                        .requestFocus(pincodeFocusController),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 10) {
                        return "StreetName is missing";
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
                      hintText: "Street Name",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color:
                                GetColorThemeService(context).headingTextColor,
                            width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color:
                                GetColorThemeService(context).headingTextColor,
                            width: 1),
                      ),
                    ),
                  ),
                  VerticalSpacingWidget(height: 5),
                  //! pincode
                  TextFormField(
                    controller: pincodeController,
                    keyboardType: TextInputType.number,
                    focusNode: pincodeFocusController,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return "Pincode is missing";
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
                      hintText: "Pincode",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color:
                                GetColorThemeService(context).headingTextColor,
                            width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color:
                                GetColorThemeService(context).headingTextColor,
                            width: 1),
                      ),
                    ),
                  ),
                  const VerticalSpacingWidget(height: 15),
                  //! signup
                  CommonButtonWidget(
                    height: 50,
                    width: double.infinity,
                    title: "SignUp",
                    onPressedFunction: () {
                      signUp();
                    },
                  ),
                  const VerticalSpacingWidget(height: 5),
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
                              context: context,
                              routeName: LoginScreen.routeName);
                        },
                        child: Text(
                          "Login",
                          style: AppTextStyle.instance.mainTextStyle(
                              fSize: 16,
                              fWeight: FontWeight.w500,
                              color: GetColorThemeService(context)
                                  .headingTextColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
    houseNameController.dispose();
    streetNameConroller.dispose();
    pincodeController.dispose();
    emailFocusController.dispose();
    passwordFocusController.dispose();
    houserNameFocusController.dispose();
    streetNameFocusController.dispose();
    pincodeFocusController.dispose();
  }
}
