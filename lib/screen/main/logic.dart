import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/assets/assets.dart';
import 'package:test_22_10_2024/utils/colors.dart';
import 'package:test_22_10_2024/utils/size_utils.dart';
import 'package:test_22_10_2024/widget/custom_image_view.dart';

import 'state.dart';

class MainLogic extends GetxController {
  final MainState state = MainState();

  void onTabTapped(int index) {
    if (index == 2) {
      //noting to do
    } else {
      state.currentIndex.value = index;
    }
  }

  Widget getImage(String imagePath, int position) {
    return Obx(
      () => state.currentIndex.value == position
          ? Stack(
              alignment: Alignment.center,
              children: [
                CustomImageView(
                  width: 25.v,
                  height: 25.v,
                  color: AppColors.mediumLight,
                  imagePath: imagePath,
                ),
                CustomImageView(
                  width: 40.v,
                  height: 35.v,
                  imagePath: Assets.selectedRing,
                )
              ],
            )
          : CustomImageView(
              width: 25.v,
              height: 25.v,
              color: AppColors.darkLight,
              imagePath: imagePath,
            ),
    );
  }
}
