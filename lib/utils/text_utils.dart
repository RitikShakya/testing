
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'color_utils.dart';
import 'dart:math' as math;


// can use these text utils for headings subhedings if not defined in the them , the global theme


class TextUtils{

  static TextStyle heading1 = TextStyle(
    color: ColorUtils.BRAND_COLOR, // ✅ Keep Deep Purple for Strongest Impact
    fontSize: 32,
    fontWeight: FontWeight.w800,
    fontFamily: "Inter",
    letterSpacing: 1.2,
  );

  static TextStyle textLabelheadings = TextStyle(
    color: ColorUtils.BRAND_COLOR, // ✅ Keep Deep Purple for Strongest Impact
    fontSize: 16,
    fontWeight: FontWeight.w800,
    fontFamily: "Inter",
    letterSpacing: 1.2,
  );



  //button text white
  static TextStyle buttonText = TextStyle(
    color: Colors.white, // ✅ Keep Deep Purple for Strongest Impact
    fontSize: 16,
    fontWeight: FontWeight.w800,
    fontFamily: "Inter",
    letterSpacing: 1.2,
  );

  static TextStyle labelStyle = TextStyle(
    color: ColorUtils.GREY_COLOR_PLACEHOLDER, // ✅ Keep Deep Purple for Strongest Impact
    fontSize: 16,
    fontWeight: FontWeight.w800,
    fontFamily: "Inter",
    letterSpacing: 1.2,
  );
}

class TextSizeDynamicUtils {

  //sizing for different fonts calculated with the context


  static var height = MediaQuery.of(Get.context!).size.height;

  static get dHeight30 {
    return math.min(height * 0.04, 30.0);
  }

}