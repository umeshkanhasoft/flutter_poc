import 'package:get/get.dart';
import 'package:test_22_10_2024/routes/app_routes.dart';
import 'package:test_22_10_2024/screen/main/binding.dart';
import 'package:test_22_10_2024/screen/main/view.dart';
import 'package:test_22_10_2024/screen/register/binding.dart';
import 'package:test_22_10_2024/screen/register/view.dart';
import 'package:test_22_10_2024/screen/splash/binding.dart';
import 'package:test_22_10_2024/screen/splash/view.dart';
import 'package:test_22_10_2024/screen/welcome/binding.dart';
import 'package:test_22_10_2024/screen/welcome/view.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: AppRoutes.splash,
        page: () => SplashPage(),
        binding: SplashBinding()),
    GetPage(
        name: AppRoutes.register,
        page: () => RegisterPage(),
        binding: RegisterBinding()),
    GetPage(
        name: AppRoutes.main, page: () => MainPage(), binding: MainBinding()),
    GetPage(
        name: AppRoutes.welcome,
        page: () => WelcomePage(),
        binding: WelcomeBinding()),
  ];
}
