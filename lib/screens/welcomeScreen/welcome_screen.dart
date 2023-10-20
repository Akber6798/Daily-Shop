import 'package:daily_shop/commonwidgets/common_button_widget.dart';
import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_data_details.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/screens/authenticationScreens/login_screen/login_screen.dart';
import 'package:daily_shop/screens/welcomeScreen/widget/welcome_screen_content_widget.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(
                      () {
                        currentPageIndex = value;
                      },
                    );
                  },
                  itemCount: welcomeScreenDatas.length,
                  itemBuilder: ((context, index) {
                    return WelcomeScreenContentWidget(
                      subText: welcomeScreenDatas[index]["subText"],
                      imageUrl: welcomeScreenDatas[index]["imageUrl"],
                    );
                  }),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          welcomeScreenDatas.length,
                          (newIndex) => buildDotIndicators(index: newIndex),
                        ),
                      ),
                      const Spacer(flex: 2),
                      CommonButtonWidget(
                        height: 50,
                        width: double.infinity,
                        title: "Continue",
                        onPressedFunction: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //! for dot indicators
  AnimatedContainer buildDotIndicators({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5.w),
      height: 8,
      width: currentPageIndex == index ? 20 : 8,
      decoration: BoxDecoration(
        color: currentPageIndex == index
            ? GetColorThemeService(context).headingTextColor
            : const Color(0xFD8D8D8D),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
