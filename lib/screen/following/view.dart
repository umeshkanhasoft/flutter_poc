import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/assets/assets.dart';
import 'package:test_22_10_2024/custom/custom_listview.dart';
import 'package:test_22_10_2024/custom/enum/custom_enum.dart';
import 'package:test_22_10_2024/screen/following/state.dart';
import 'package:test_22_10_2024/service/api_client.dart';
import 'package:test_22_10_2024/service/api_constant.dart';
import 'package:test_22_10_2024/widget/empty_widget.dart';

import 'logic.dart';

class FollowingPage extends StatelessWidget {
  FollowingPage({super.key});

  final FollowingLogic logic = Get.put(FollowingLogic());
  final FollowingState state = Get.find<FollowingLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => CustomListview(
            emptyWidget: emptyWidget(
                Assets.followingFollowersListNotFound,
                "You don't have any followers yet"),
            contents: state.content,
            isPagination: true,
            type: CustomCellListview.following,
            customApiRequestClass: CustomApiRequestClass(
                dataParam: {},
                queryParam: {
                  if (state.userId.value.isNotEmpty)
                    'user_id': state.userId.value
                },
                method: ApiMethod.GET,
                url: ApiConstant.userFollowing)),
      ),
    );
  }
}
