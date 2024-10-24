import 'package:flutter/material.dart';
import 'package:test_22_10_2024/utils/colors.dart';
import 'package:test_22_10_2024/utils/size_utils.dart';
import 'package:test_22_10_2024/widget/empty_widget.dart';

class CustomSmallButton extends StatefulWidget {
  const CustomSmallButton({
    super.key,
    required this.text,
    this.isLoading = false,
    this.color = AppColors.light,
    required this.onTap,
    required this.isEnabled,
    this.margin,
    this.iconPrefix,
    this.isActive,
  });

  final String text;
  final Color color;
  final EdgeInsetsGeometry? margin;
  final bool isLoading;
  final Widget? iconPrefix;
  final Function() onTap;
  final bool isEnabled;
  final bool? isActive;

  @override
  State<CustomSmallButton> createState() => _CustomSmallButtonState();
}

class _CustomSmallButtonState extends State<CustomSmallButton> {
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
        margin: widget.margin,
        padding: EdgeInsets.symmetric(horizontal: 13.v, vertical: 5.v),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.v),
          color: widget.isEnabled
              ? widget.isActive == true
                  ? AppColors.lightDark
                  : widget.color
              : AppColors.lightDark,
        ),
        child: widget.isLoading
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.v),
                child: SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(
                    color: widget.isActive == true
                        ? AppColors.light
                        : AppColors.darkLight,
                    strokeWidth: 2,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    style: getSupremeStyle(
                      color: widget.isEnabled
                          ? widget.isActive == true
                              ? AppColors.light
                              : AppColors.heavyDark
                          : AppColors.darkLight,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.fSize,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
