import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/utils/colors.dart';
import 'package:test_22_10_2024/widget/empty_widget.dart';
import 'package:test_22_10_2024/widget/loader.dart';

import 'logic.dart';

class WelcomePage extends GetWidget<WelcomeLogic> {
  final state = Get.find<WelcomeLogic>().state;
  final logic = Get.find<WelcomeLogic>();

  WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showCommonModelSheet(logic.welcomeWidget()),
      child: Center(
        child: Text(
          "Welcome Screen",
          style: getSupremeStyle(color: AppColors.light),
        ),
      ),
    );
  }
}
