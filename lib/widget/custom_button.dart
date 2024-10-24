import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/utils/colors.dart';
import 'package:test_22_10_2024/utils/size_utils.dart';

class CustomButton extends StatefulWidget {
  const CustomButton(
      {super.key,
      required this.text,
      this.isLoading = false,
      this.color = AppColors.light,
      required this.onTap,
      required this.isEnabled,
      this.margin,
      this.iconPrefix,
      this.iconSuffix,
      this.textColor,
      this.borderRadius,
      this.textStyle});

  final String text;
  final Color? textColor;
  final Color color;
  final EdgeInsetsGeometry? margin;
  final bool isLoading;
  final Widget? iconPrefix;
  final Widget? iconSuffix;
  final Function() onTap;
  final bool isEnabled;
  final double? borderRadius;
  final TextStyle? textStyle;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isEnabled
          ? () async {
              widget.onTap();
            }
          : () {},
      child: Container(
        alignment: Alignment.center,
        width: Get.width,
        margin: widget.margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.v),
          color: widget.isEnabled ? widget.color : AppColors.lightDark,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.v, horizontal: 12.v),
          child: widget.isLoading
              ? SizedBox(
                  height: 24.fSize,
                  width: 24.fSize,
                  child: const CircularProgressIndicator(
                    color: AppColors.lightDark,
                    strokeWidth: 2,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Button Icon: if available
                    Visibility(
                      visible: widget.iconPrefix != null,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.v),
                        child: widget.iconPrefix ?? Container(),
                      ),
                    ),

                    // Button Text
                    Text(
                      widget.text,
                      style: widget.textStyle ??
                          TextStyle(
                            fontFamily: 'SupremeFonts',
                            fontWeight: FontWeight.w500,
                            fontSize: 19.fSize,
                            color: widget.isEnabled
                                ? widget.textColor ?? AppColors.heavyDark
                                : AppColors.darkLight,
                          ),
                    ),

                    Visibility(
                      visible: widget.iconSuffix != null,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.v),
                        child: widget.iconSuffix ?? Container(),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
