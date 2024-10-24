import 'package:get/get.dart';
import 'package:test_22_10_2024/model/user.dart';

class FollowingState {
  RxList<Users> content = <Users>[].obs;
  RxString userId = "".obs;
  Map<String, dynamic> loginUser = {};
  RxBool isFollowingFollowerApiLoader = false.obs;

  FollowingState() {
    ///Initialize variables
  }
}
