import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/assets/assets.dart';
import 'package:test_22_10_2024/utils/size_utils.dart';
import 'package:test_22_10_2024/widget/custom_image_view.dart';
import 'logic.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  final logic = Get.find<SplashLogic>();
  final state = Get.find<SplashLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomImageView(imagePath: Assets.imgLogo, height: 64.v),
    );
  }
}
