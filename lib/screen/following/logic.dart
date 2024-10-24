import 'dart:convert';

import 'package:get/get.dart';
import 'package:test_22_10_2024/custom/enum/custom_enum.dart';
import 'package:test_22_10_2024/model/user.dart';
import 'package:test_22_10_2024/service/api_client.dart';
import 'package:test_22_10_2024/service/api_constant.dart';
import 'package:test_22_10_2024/service/base_response.dart';
import 'package:test_22_10_2024/utils/shared_preferences.dart';

import 'state.dart';

class FollowingLogic extends GetxController {
  final FollowingState state = FollowingState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setUpLoginDetail();
    Map<String, dynamic> argument = Get.arguments;
    if (argument.containsKey('user_id')) {
      state.userId.value = argument['user_id'];
    }
  }

  setUpLoginDetail() async {
    String? loginResponse = await SharedPreferencesService().getLoginUser();
    state.loginUser = await jsonDecode(loginResponse!);
  }

  callApiFollowUnFollowApi(Users? item, CustomCellListview? type) async {
    item?.isLoading?.value = true;

    ApiResponse? response = await ApiClient.instance.call(
      url: ApiConstant.followUnFollow,
      queryParams: {'followedID': item?.id},
      method: ApiMethod.POST,
    );

    item?.isLoading?.value = false;

    if (response is DataResponse) {
      if (response.status == true) {
        var value = state.loginUser['number_of_following'];
        if (type == CustomCellListview.following) {
          value = state.loginUser['number_of_following'];
        } else if (type == CustomCellListview.followers) {
          value = state.loginUser['number_of_followers'];
        }
        item?.followed = (item.followed) == true ? false : true;
        if (item?.followed == true) {
          value = (value as int) + 1;
        } else {
          if ((value as int) >= 0) {
            value = value - 1;
          }
        }
        await SharedPreferencesService().setLoginUser(jsonEncode(state.loginUser));
      }
    }
  }
}
