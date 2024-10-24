import 'package:get/get.dart';

import 'logic.dart';

class DiscoveryHashTagBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiscoveryHashTagLogic());
  }
}
