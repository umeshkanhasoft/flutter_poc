import 'package:flutter/material.dart';
import 'package:test_22_10_2024/utils/colors.dart';
import 'package:test_22_10_2024/widget/custom_button.dart';
import 'package:test_22_10_2024/widget/empty_widget.dart';

class RegisterPassword extends StatelessWidget {
  const RegisterPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar:
            CustomButton(text: "Continue", onTap: () {}, isEnabled: false),
        body: Center(
          child: Text(
            "Register Password",
            style: getSupremeStyle(color: AppColors.light),
          ),
        ));
  }
}
