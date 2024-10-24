import 'package:get/get.dart';

import 'logic.dart';

class DiscoveryAllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiscoveryAllLogic());
  }
}
