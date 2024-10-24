import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/assets/assets.dart';
import 'package:test_22_10_2024/screen/main/discover/view.dart';
import 'package:test_22_10_2024/screen/main/home/view.dart';
import 'package:test_22_10_2024/screen/main/map/view.dart';
import 'package:test_22_10_2024/screen/main/profile/view.dart';
import 'package:test_22_10_2024/utils/colors.dart';
import 'package:test_22_10_2024/utils/size_utils.dart';

import 'logic.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final logic = Get.find<MainLogic>();
  final state = Get.find<MainLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: state.currentIndex.value,
          children: [
            HomePage(),
            DiscoverPage(),
            Container(),
            MapPage(),
            ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(
          () => BottomNavigationBar(
            currentIndex: state.currentIndex.value,
            onTap: logic.onTabTapped,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.mediumLight,
            backgroundColor: AppColors.heavyDark,
            unselectedItemColor: AppColors.darkLight,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedLabelStyle: const TextStyle(height: 0),
            unselectedLabelStyle: const TextStyle(height: 0),
            selectedFontSize: 0,
            unselectedFontSize: 0,
            items: [
              BottomNavigationBarItem(
                icon: logic.getImage(Assets.home, 0),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: logic.getImage(Assets.discovery, 1),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 30.v,
                  height: 30.v,
                  decoration: BoxDecoration(
                      color: AppColors.light,
                      borderRadius: BorderRadius.circular(6.v)),
                  child: const Center(
                    child: Icon(Icons.add),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: logic.getImage(Assets.map, 3),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: logic.getImage(Assets.profile, 4),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
