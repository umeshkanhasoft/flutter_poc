import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/routes/app_pages.dart';
import 'package:test_22_10_2024/routes/app_routes.dart';
import 'package:test_22_10_2024/screen/init_binding.dart';
import 'package:test_22_10_2024/utils/app_logs.dart';
import 'package:test_22_10_2024/utils/colors.dart';
import 'package:test_22_10_2024/utils/env.dart';
import 'package:test_22_10_2024/utils/size_utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initStuff().then((value) {
    runApp(const MyApp());
  });
}

Future initStuff() async {
  appLogs("<>>>>>> current flavor >>>>>>>>>> $appFlavor");
  var fileName =
      appFlavor == 'prod' ? Environment.prodFileName : Environment.devFileName;
  await dotenv.load(fileName: fileName);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Soul Train',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mediumLight),
        scaffoldBackgroundColor: AppColors.heavyDark,
        useMaterial3: true,
      ),
      initialBinding: InitialBinding(),
      builder: (context, child) {
        mediaQueryData = MediaQuery.of(context);
        return ScaffoldMessenger(
          child: Scaffold(
              backgroundColor: AppColors.heavyDark, body: child ?? Container()),
        );
      },
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
