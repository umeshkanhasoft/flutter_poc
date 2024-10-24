import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/screen/main/discover/discovery_music/state.dart';

import 'logic.dart';

class DiscoveryMusicPage extends StatelessWidget {
  final DiscoveryMusicLogic logic = Get.put(DiscoveryMusicLogic());
  final DiscoveryMusicState state = Get.find<DiscoveryMusicLogic>().state;

  DiscoveryMusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Music"),
    );
  }
}
