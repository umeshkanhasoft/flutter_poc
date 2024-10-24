import 'package:get/get.dart';

import 'logic.dart';

class DiscoveryMusicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiscoveryMusicLogic());
  }
}
