import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/screen/main/discover/discovery_live/state.dart';

import 'logic.dart';

class DiscoveryLivePage extends StatelessWidget {
  final DiscoveryLiveLogic logic = Get.put(DiscoveryLiveLogic());
  final DiscoveryLiveState state = Get.find<DiscoveryLiveLogic>().state;

  DiscoveryLivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Live"),
    );
  }
}
