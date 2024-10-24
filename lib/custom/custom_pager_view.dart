import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/assets/assets.dart';
import 'package:test_22_10_2024/utils/size_utils.dart';
import 'package:test_22_10_2024/widget/custom_image_view.dart';
import 'package:test_22_10_2024/widget/step_indicator.dart';

class CustomPagerView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomPagerState();

  const CustomPagerView({super.key,
    required this.selectedIndex,
    required this.pageController,
    required this.totalSteps,
    required this.listWidget,
    required this.onBack,
    this.isEnableSwipe = false,
    this.isShowBackArrow = false,
  });

  final PageController? pageController;
  final RxInt? selectedIndex;
  final RxInt? totalSteps;
  final bool? isEnableSwipe;
  final bool? isShowBackArrow;
  final Function()? onBack;

  final List<Widget>? listWidget;
}

class _CustomPagerState extends State<CustomPagerView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.isShowBackArrow == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomImageView(
                    imagePath: Assets.arrowBack,
                    height: 20.v,
                    width: 20.v,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      widget.onBack!();
                    },
                  ),
                  Obx(() {
                    return StepIndicator(
                      isProfile: false,
                      currentStep: widget.selectedIndex!.value,
                      totalSteps: widget.totalSteps!.value,
                    );
                  }).paddingOnly(bottom: 15),
                  const SizedBox()
                ],
              )
            : Center(
                child: Obx(() {
                  return StepIndicator(
                    isProfile: false,
                    currentStep: widget.selectedIndex!.value,
                    totalSteps: widget.totalSteps!.value,
                  );
                }),
              ).paddingOnly(bottom: 15.v),
        Expanded(
            child: PageView(
          controller: widget.pageController,
          physics: widget.isEnableSwipe == true
              ? const ScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          children: widget.listWidget!,
        ))
      ],
    );
  }
}
