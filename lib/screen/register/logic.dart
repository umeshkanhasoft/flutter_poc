import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'state.dart';

class RegisterLogic extends GetxController {
  PageController pageController = PageController();
  final RegisterState state = RegisterState();

  void continueClick(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (validationCreateForm()) {
      nextScreen(context);
    }
  }

  nextScreen(BuildContext context) {
    if (state.selectedIndex.value < (state.totalSteps.value - 1)) {
      state.selectedIndex.value = state.selectedIndex.value + 1;
      pageController.nextPage(
        duration: const Duration(milliseconds: 30),
        curve: Curves.ease,
      );
    }
  }

  bool validationCreateForm() {
    switch (state.selectedIndex.value) {
      case 0:
        return false;
      case 1:
        return false;
      case 2:
        return false;
      case 3:
        return false;
      case 4:
        return false;
    }
    return true;
  }
}
