import 'package:get/get.dart';

import 'logic.dart';

class DiscoveryEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiscoveryEventLogic());
  }
}
