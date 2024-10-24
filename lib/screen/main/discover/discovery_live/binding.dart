import 'package:get/get.dart';

import 'logic.dart';

class DiscoveryLiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiscoveryLiveLogic());
  }
}
