import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static AppTextStyle instance = AppTextStyle();

  //* main text style
  TextStyle mainTextStyle(
      {required double fSize,
      required FontWeight fWeight,
      required Color color}) {
    return GoogleFonts.poppins(
        fontSize: fSize.sp, color: color, fontWeight: fWeight);
  }
}
