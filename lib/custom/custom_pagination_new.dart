import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/utils/colors.dart';
import 'package:test_22_10_2024/utils/size_utils.dart';
import 'package:test_22_10_2024/widget/empty_widget.dart';

class CustomPaginationNew extends StatefulWidget {
  const CustomPaginationNew(
      {super.key, this.widgets, this.listItem, this.selectedWidget});

  final List<Widget>? widgets;
  final List<String>? listItem;
  final Function(int)? selectedWidget;

  @override
  State<CustomPaginationNew> createState() => _CustomPaginationNewState();
}

class _CustomPaginationNewState extends State<CustomPaginationNew> {
  PageController pageController = PageController();
  var itemSelected = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding:
              EdgeInsets.only(top: 5.v, bottom: 10.v, left: 20.v, right: 20.v),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              widget.listItem!.length,
              (index) => GestureDetector(
                onTap: () {
                  itemSelected.value = index;
                  if (pageController.hasClients) {
                    pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                  widget.selectedWidget!(index);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10.v),
                  child: Obx(() {
                    return Text(
                      widget.listItem![index],
                      style: getClashStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.fSize,
                        color: itemSelected.value == index
                            ? AppColors.mediumLight
                            : AppColors.darkLight,
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),

        // DISCOVERY: contents
        Expanded(
          child: PageView(
            controller: pageController,
            onPageChanged: (index) {
              itemSelected.value = index;
              widget.selectedWidget!(index);
            },
            children: widget.widgets!,
          ),
        )
      ]),
    );
  }
}
