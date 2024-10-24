import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/utils/colors.dart';
import 'package:test_22_10_2024/utils/size_utils.dart';

class LoaderOverlay extends StatelessWidget {
  const LoaderOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1.7, sigmaY: 1.7),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

showCommonModelSheet(Widget widget) {
  showModalBottomSheet(
    context: Get.context!,
    enableDrag: true,
    isDismissible: true,
    isScrollControlled: true,
    backgroundColor: AppColors.mediumDark,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.7, sigmaY: 1.7),
        child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.zero, // Remove rounded corners
            ),
            width: Get.width,
            child: Padding(
              padding: EdgeInsets.all(15.v),
              child: widget,
            )),
      );
    },
  );
}
