import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/screen/main/discover/discovery_all/state.dart';

import 'logic.dart';

class DiscoveryAllPage extends StatelessWidget {
  DiscoveryAllPage({super.key});

  final DiscoveryAllLogic logic = Get.put(DiscoveryAllLogic());
  final DiscoveryAllState state = Get.find<DiscoveryAllLogic>().state;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("All"),
    );
  }
}
