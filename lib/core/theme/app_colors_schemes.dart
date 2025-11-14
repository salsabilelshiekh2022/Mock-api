import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppColorsSchemes {
  static AppColors light = AppColors(
    whiteColor: Colors.white,
    primaryColor: const Color(0xFF427399),
    secondaryColor: const Color(0xff363A33),
    grayColor: const Color(0xffB3B3B3),
    strokeColor: const Color(0xff9B9B9B).withValues(alpha: 0.12),
    backgroundFieldColor: const Color(0xff9b9b9b).withValues(alpha: 0.08),
    redColor: const Color(0xffD76969),
    greenColor: const Color(0xff00840F),
    yellowColor: const Color(0xffDAB900),
  );

  static AppColors dark = light;
}
