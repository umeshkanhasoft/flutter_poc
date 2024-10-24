import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/screen/main/map/state.dart';

import 'logic.dart';

class MapPage extends StatelessWidget {
  final MapLogic logic = Get.put(MapLogic());
  final MapState state = Get.find<MapLogic>().state;

  MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Map"),
    );
  }
}
