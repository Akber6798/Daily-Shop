import 'package:daily_shop/consts/app_colors.dart';
import 'package:daily_shop/consts/app_text_style.dart';
import 'package:daily_shop/services/get_theme_color_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GlobalServices {
  static GlobalServices instance = GlobalServices();

  //* for navigation
  navigateTo({required BuildContext context, required String routeName}) {
    Navigator.pushNamed(context, routeName);
  }

  //* for closing dialogue
  closingDailogue(BuildContext context, String title, String content,
      Function yesFunction) {
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
            title,
            style: AppTextStyle.instance.mainTextStyle(
                fSize: 21,
                fWeight: FontWeight.bold,
                color: GetColorThemeService(context).headingTextColor),
          ),
          content: Text(
            content,
            style: AppTextStyle.instance.mainTextStyle(
                fSize: 18,
                fWeight: FontWeight.w400,
                color: GetColorThemeService(context).textColor),
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
              onPressed: () {
                yesFunction();
                Navigator.pop(context);
              },
              child: Text(
                "Yes",
                style: AppTextStyle.instance.mainTextStyle(
                    fSize: 18, fWeight: FontWeight.bold, color: redColor),
              ),
            )
          ],
        );
      }),
    );
  }

  //* for error
  errorDailogue(BuildContext context, String content) {
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
            "An error occured",
            style: AppTextStyle.instance.mainTextStyle(
                fSize: 21,
                fWeight: FontWeight.bold,
                color: GetColorThemeService(context).headingTextColor),
          ),
          content: Text(
            content,
            style: AppTextStyle.instance.mainTextStyle(
                fSize: 18,
                fWeight: FontWeight.w400,
                color: GetColorThemeService(context).textColor),
          ),
          actions: [
            TextButton(
              child: Text(
                "Ok",
                style: AppTextStyle.instance.mainTextStyle(
                    fSize: 16,
                    fWeight: FontWeight.w800,
                    color: GetColorThemeService(context).headingTextColor),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      }),
    );
  }

   //* to show toast
  showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey.shade600,
        textColor: whiteColor,
        fontSize: 16.sp);
  }

  //* to close the app
  appCloseDialogue(
      BuildContext context, String title, void Function()? yesFunction) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: ((context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          content: Text(
            title,
            style: AppTextStyle.instance.mainTextStyle(
                fSize: 21,
                fWeight: FontWeight.bold,
                color: GetColorThemeService(context).headingTextColor),
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
              onPressed: yesFunction,
              child: Text(
                "Yes",
                style: AppTextStyle.instance.mainTextStyle(
                    fSize: 18, fWeight: FontWeight.bold, color: redColor),
              ),
            )
          ],
        );
      }),
    );
  }
}
