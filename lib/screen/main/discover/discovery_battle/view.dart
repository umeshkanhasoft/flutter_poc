import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/screen/main/discover/discovery_battle/state.dart';

import 'logic.dart';

class DiscoveryBattlePage extends StatelessWidget {
  final DiscoveryBattleLogic logic = Get.put(DiscoveryBattleLogic());
  final DiscoveryBattleState state = Get.find<DiscoveryBattleLogic>().state;

  DiscoveryBattlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Battle"),
    );
  }
}
