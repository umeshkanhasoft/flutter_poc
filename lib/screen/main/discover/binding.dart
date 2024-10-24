import 'package:get/get.dart';

import 'logic.dart';

class DiscoverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiscoverLogic());
  }
}
