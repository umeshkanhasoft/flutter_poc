import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/custom/custom_pagination_new.dart';
import 'package:test_22_10_2024/screen/main/discover/discovery_all/view.dart';
import 'package:test_22_10_2024/screen/main/discover/discovery_battle/view.dart';
import 'package:test_22_10_2024/screen/main/discover/discovery_event/view.dart';
import 'package:test_22_10_2024/screen/main/discover/discovery_hash_tag/view.dart';
import 'package:test_22_10_2024/screen/main/discover/discovery_live/view.dart';
import 'package:test_22_10_2024/screen/main/discover/discovery_music/view.dart';
import 'package:test_22_10_2024/screen/main/discover/state.dart';

import 'logic.dart';

class DiscoverPage extends StatelessWidget {
  final DiscoverLogic logic = Get.put(DiscoverLogic());
  final DiscoverState state = Get.find<DiscoverLogic>().state;

  DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomPaginationNew(
          selectedWidget: (p0) {},
          listItem: const ["All", "#", "Battles", "Music", "Live", "Event"],
          widgets: [
            DiscoveryAllPage(),
            DiscoveryHashTagPage(),
            DiscoveryBattlePage(),
            DiscoveryMusicPage(),
            DiscoveryLivePage(),
            DiscoveryEventPage(),
          ],
        ),
      ),
    );
  }
}
