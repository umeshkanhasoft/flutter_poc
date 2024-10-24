import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/screen/main/discover/discovery_event/state.dart';

import 'logic.dart';

class DiscoveryEventPage extends StatelessWidget {
  final DiscoveryEventLogic logic = Get.put(DiscoveryEventLogic());
  final DiscoveryEventState state = Get.find<DiscoveryEventLogic>().state;

  DiscoveryEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Event"),
    );
  }
}
