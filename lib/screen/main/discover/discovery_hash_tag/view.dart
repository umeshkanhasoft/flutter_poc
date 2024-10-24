import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/screen/main/discover/discovery_hash_tag/state.dart';

import 'logic.dart';

class DiscoveryHashTagPage extends StatelessWidget {
  final DiscoveryHashTagLogic logic = Get.put(DiscoveryHashTagLogic());
  final DiscoveryHashTagState state = Get.find<DiscoveryHashTagLogic>().state;

  DiscoveryHashTagPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Hash Tag"),
    );
  }
}
