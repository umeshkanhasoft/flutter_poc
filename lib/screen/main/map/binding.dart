import 'package:get/get.dart';

import 'logic.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MapLogic());
  }
}
