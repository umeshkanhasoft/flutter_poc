import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/custom/custom_pager_view.dart';
import 'package:test_22_10_2024/screen/register/pages/artist_name.dart';
import 'package:test_22_10_2024/screen/register/pages/confirm_password.dart';
import 'package:test_22_10_2024/screen/register/pages/date_of_birth.dart';
import 'package:test_22_10_2024/screen/register/pages/email.dart';
import 'package:test_22_10_2024/screen/register/pages/name.dart';
import 'package:test_22_10_2024/screen/register/pages/otp.dart';
import 'package:test_22_10_2024/screen/register/pages/password.dart';

import 'logic.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final state = Get.find<RegisterLogic>().state;
  final controller = Get.find<RegisterLogic>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: CustomPagerView(
        isEnableSwipe: true,
        selectedIndex: state.selectedIndex,
        pageController: controller.pageController,
        totalSteps: state.totalSteps,
        listWidget: const [
          RegisterEmail(),
          RegisterOtp(),
          RegisterName(),
          RegisterDateOfBirth(),
          RegisterArtistName(),
          RegisterPassword(),
          RegisterConfirmPassword(),
        ],
        onBack: () {},
      ),
    ));
  }
}
