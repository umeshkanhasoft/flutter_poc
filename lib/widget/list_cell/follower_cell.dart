import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/assets/assets.dart';
import 'package:test_22_10_2024/custom/enum/custom_enum.dart';
import 'package:test_22_10_2024/model/user.dart';
import 'package:test_22_10_2024/screen/following/logic.dart';
import 'package:test_22_10_2024/screen/following/state.dart';
import 'package:test_22_10_2024/utils/colors.dart';
import 'package:test_22_10_2024/utils/size_utils.dart';
import 'package:test_22_10_2024/widget/custom_button_small.dart';
import 'package:test_22_10_2024/widget/empty_widget.dart';

class FollowerCell extends StatefulWidget {
  const FollowerCell({super.key, this.item, this.type});

  final Users? item;
  final CustomCellListview? type;

  @override
  State<FollowerCell> createState() => _BattleVoteCellState();
}

class _BattleVoteCellState extends State<FollowerCell> {
  final FollowingState state = Get.find<FollowingLogic>().state;
  final FollowingLogic logic = Get.put(FollowingLogic());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: widget.item?.profilePicture?.isNotEmpty == true &&
                      widget.item?.profilePicture?.startsWith('http') == true
                  ? CachedNetworkImage(
                      width: 50.v,
                      height: 50.v,
                      fit: BoxFit.cover,
                      key: ValueKey(widget.item?.profilePicture),
                      imageUrl: "${widget.item?.profilePicture}",
                      placeholder: (context, url) => SizedBox(
                        width: 50.v,
                        height: 50.v,
                        child: LinearProgressIndicator(
                          color: Colors.grey.shade200,
                          backgroundColor: Colors.grey.shade100,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          Image.asset(Assets.systemAvatar),
                    )
                  : Image.asset(
                      Assets.systemAvatar,
                      width: 50.v,
                      height: 50.v,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(width: 15.v),
            Flexible(
              child: Container(
                padding: EdgeInsets.only(bottom: 15.v),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.mediumLight,
                      width: 0.2.v,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${widget.item?.username}",
                              style: getSupremeStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.light,
                                  fontSize: 17.fSize)),
                          SizedBox(height: 5.v),
                          Text("${widget.item?.artistName}",
                              style: getSupremeStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.light,
                                  fontSize: 17.fSize))
                        ],
                      ),
                    ),
                    state.loginUser['id'] != widget.item?.id
                        ? CustomSmallButton(
                            isLoading: widget.item?.isLoading?.value == true
                                ? true
                                : false,
                            text: widget.item?.followed == true
                                ? "Following"
                                : "Follow",
                            onTap: () => logic.callApiFollowUnFollowApi(
                                widget.item, widget.type),
                            isEnabled: true,
                            isActive: widget.item?.followed,
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
