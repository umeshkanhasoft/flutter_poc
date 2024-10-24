import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/utils/colors.dart';
import 'package:test_22_10_2024/utils/size_utils.dart';

class StepIndicator extends StatelessWidget {
  const StepIndicator(
      {super.key,
      required this.currentStep,
      required this.totalSteps,
      required this.isProfile});

  final int currentStep;
  final int totalSteps;

  final bool isProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: isProfile || totalSteps == 1 ? Get.width / 4 : Get.width / 2,
        padding: EdgeInsets.symmetric(vertical: isProfile ? 3.h : 20.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            totalSteps,
            (index) => Flexible(
              flex: currentStep == index ? 2 : 1,
              child: Container(
                height: 3.h,
                margin: EdgeInsets.symmetric(horizontal: 2.v),
                decoration: BoxDecoration(
                  color: currentStep == index
                      ? AppColors.light
                      : AppColors.darkLight,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
              ),
            ),
          ).toList(),
        ));
  }
}
