
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/utils/colors.dart';
import 'package:test_22_10_2024/utils/size_utils.dart';
import 'package:test_22_10_2024/widget/empty_widget.dart';

import 'state.dart';

class WelcomeLogic extends GetxController {
  final WelcomeState state = WelcomeState();

  Widget welcomeWidget() {
    return Text(
      "dasdasdasd",
      style: getSupremeStyle(color: AppColors.light, fontSize: 17.fSize),
    );
  }
}
