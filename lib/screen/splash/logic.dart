import 'package:get/get.dart';
import 'package:test_22_10_2024/routes/app_routes.dart';
import 'package:test_22_10_2024/utils/app_logs.dart';
import 'package:test_22_10_2024/utils/shared_preferences.dart';

import 'state.dart';

class SplashLogic extends GetxController {
  final SplashState state = SplashState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    appLogs("<><>Call Splash Init");
    initUserSession();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    appLogs("<><>Call Splash Ready");
  }

  initUserSession() async {
    bool? isLogin = await SharedPreferencesService().isLogin();
    Future.delayed(const Duration(milliseconds: 3000), () {
      Get.offNamed(isLogin == true ? AppRoutes.main : AppRoutes.welcome);
    });
  }
}
