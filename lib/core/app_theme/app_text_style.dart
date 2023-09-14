import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constants.dart';
import 'app_theme.dart';

const String fontFamily = "Montserrat";
const FontWeight fontWeight500 = FontWeight.w500;
const FontWeight fontWeight400 = FontWeight.w400;
const FontWeight fontWeightw700 = FontWeight.w700;

class AppTextStyle {
  static TextStyle textStyle1 = TextStyle(
    fontSize: AppFontSize.fontSizeFortyFour.sp,
    color: primaryColor,
    fontWeight: fontWeight500,
    fontFamily: fontFamily,
  );

  static TextStyle textStyle2 = TextStyle(
    fontSize: AppFontSize.fontSizeSixteen.sp,
    color: grey,
    fontWeight: fontWeight500,
    fontFamily: fontFamily,
  );

  static TextStyle textStyle3 = TextStyle(
    fontSize: AppFontSize.fontSizeFourteen.sp,
    color: black,
    fontWeight: fontWeight400,
    fontFamily: fontFamily,
  );

  static TextStyle textStyle4 = TextStyle(
    fontSize: AppFontSize.fontSizeSixteen.sp,
    color: white,
    fontWeight: fontWeight500,
    fontFamily: fontFamily,
  );

  static TextStyle textStyle5 = TextStyle(
    fontSize: AppFontSize.fontSizeFourteen.sp,
    color: grey,
    fontWeight: fontWeight500,
    fontFamily: fontFamily,
  );

  static TextStyle textStyle6 = TextStyle(
    fontSize: AppFontSize.fontSizeFourteen.sp,
    color: primaryColor,
    fontWeight: fontWeight500,
    fontFamily: fontFamily,
  );

  static TextStyle textStyle7 = TextStyle(
    fontSize: AppFontSize.fontSizeSixteen.sp,
    color: black,
    fontWeight: fontWeight500,
    fontFamily: fontFamily,
  );

  static TextStyle textStyle8 = TextStyle(
    fontSize: AppFontSize.fontSizeTwelve.sp,
    color: black,
    fontWeight: fontWeightw700,
    fontFamily: fontFamily,
  );

   static TextStyle textStyle9 = TextStyle(
    fontSize: AppFontSize.fontSizeTwelve.sp,
    color: black,
    fontWeight: fontWeight400,
    fontFamily: fontFamily,
  );
}
