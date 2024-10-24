import 'package:flutter/widgets.dart';
import 'package:test_22_10_2024/utils/colors.dart';
import 'package:test_22_10_2024/utils/size_utils.dart';
import 'package:test_22_10_2024/widget/custom_image_view.dart';

Widget emptyWidget(String imagePath, String title) {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      // Icon
      CustomImageView(
        fit: BoxFit.contain,
        width: 30.v,
        height: 30.v,
        imagePath: imagePath,
      ),
      SizedBox(height: 10.v),

      // Text
      Text(
        title,
        style: TextStyle(
          fontSize: 14.fSize,
          fontFamily: "Supreme",
          fontWeight: FontWeight.w400,
          color: AppColors.mediumLight,
        ),
      ),
    ],
  ));
}

TextStyle getSupremeStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  TextDecoration? decoration,
  double? height,
  double? letterSpacing,
  Color? textDecorationColor,
  TextDecorationStyle? textDecorationStyle,
}) {
  return TextStyle(
    fontFamily: "SupremeFonts",
    color: color ?? AppColors.mediumDark,
    letterSpacing: letterSpacing ?? 0.3,
    decoration: decoration,
    fontSize: fontSize ?? 15.fSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    height: height,
    decorationColor: textDecorationColor,
    decorationStyle: textDecorationStyle,
  );
}

TextStyle getClashStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  TextDecoration? decoration,
  double? height,
  double? letterSpacing,
  Color? textDecorationColor,
  TextDecorationStyle? textDecorationStyle,
}) {
  return TextStyle(
    fontFamily: "ClashDisplay",
    color: color ?? AppColors.mediumDark,
    letterSpacing: letterSpacing ?? 0.3,
    decoration: decoration,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    height: height,
    decorationColor: textDecorationColor,
    decorationStyle: textDecorationStyle,
  );
}
