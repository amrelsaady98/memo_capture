import 'package:flutter/material.dart';
import 'package:memo_capture/configs/theme/colors.dart';

class AppFontStyles {
  static const header_1 = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.dark_color,
  );
  static const header_2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.taupe_color,
  );
  static const subtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.dark_50_color,
    letterSpacing: 2,
  );
  static const body = TextStyle(
    fontSize: 18,
    color: AppColors.text_color,
  );
  static const button = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.dark_color,
    letterSpacing: 1.5,
  );
  static const label = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.text_color,
  );
  static const link = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.bright_color,
    letterSpacing: 2,
  );
  static const caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: AppColors.dark_color,
  );
}
