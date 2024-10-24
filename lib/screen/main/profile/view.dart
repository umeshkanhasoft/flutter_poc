import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/screen/main/profile/state.dart';

import 'logic.dart';

class ProfilePage extends StatelessWidget {
  final ProfileLogic logic = Get.put(ProfileLogic());
  final ProfileState state = Get.find<ProfileLogic>().state;

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Profile"),
    );
  }
}
