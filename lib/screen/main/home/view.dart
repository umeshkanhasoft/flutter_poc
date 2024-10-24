import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/assets/assets.dart';
import 'package:test_22_10_2024/custom/custom_listview.dart';
import 'package:test_22_10_2024/custom/enum/custom_enum.dart';
import 'package:test_22_10_2024/screen/main/home/state.dart';
import 'package:test_22_10_2024/service/api_client.dart';
import 'package:test_22_10_2024/service/api_constant.dart';
import 'package:test_22_10_2024/widget/empty_widget.dart';

import 'logic.dart';

class HomePage extends StatelessWidget {
  final HomeLogic logic = Get.put(HomeLogic());
  final HomeState state = Get.find<HomeLogic>().state;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomListview(
          emptyWidget: emptyWidget(Assets.followingFollowersListNotFound,
              "You don't have any followers yet"),
          contents: state.content,
          isPagination: true,
          type: CustomCellListview.homeFeed,
          customApiRequestClass: CustomApiRequestClass(
              dataParam: {},
              queryParam: {},
              method: ApiMethod.GET,
              url: ApiConstant.getHomeFeedPosts)),
    );
  }
}
