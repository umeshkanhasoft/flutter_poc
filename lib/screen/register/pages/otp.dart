import 'package:flutter/material.dart';
import 'package:test_22_10_2024/utils/colors.dart';
import 'package:test_22_10_2024/widget/custom_button.dart';
import 'package:test_22_10_2024/widget/empty_widget.dart';

class RegisterOtp extends StatelessWidget {
  const RegisterOtp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar:
            CustomButton(text: "Continue", onTap: () {}, isEnabled: false),
        body: Center(
          child: Text(
            "Register OTP",
            style: getSupremeStyle(color: AppColors.light),
          ),
        ));
  }
}
