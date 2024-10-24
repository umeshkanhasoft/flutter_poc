import 'dart:convert';

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/model/post_model.dart';
import 'package:test_22_10_2024/utils/colors.dart';
import 'package:test_22_10_2024/utils/size_utils.dart';
import 'package:test_22_10_2024/widget/custom_image_view.dart';
import 'package:test_22_10_2024/widget/empty_widget.dart';
import 'package:test_22_10_2024/widget/list_cell/feed_cell/widget/asset_widget.dart';

class FeedCell extends StatefulWidget {
  const FeedCell(
      {super.key,
      required this.postItem,
      required this.mute,
      required this.muteAllVideo});

  final Post postItem;
  final RxBool muteAllVideo;
  final Function(bool mute)? mute;

  @override
  State<FeedCell> createState() => _FeedCellState();
}

class _FeedCellState extends State<FeedCell> {
  PageController? pageController;
  RxInt currentPage = 1.obs;
  RxString location = "".obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
    initLocation();
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }

  initLocation() {
    if (widget.postItem.location is Map) {
      Map<String, dynamic> object =
          widget.postItem.location as Map<String, dynamic>;
      if (object.containsKey('description')) {
        location.value = object['description'];
      } else {
        if (object.containsKey('placename')) {
          location.value = object['placename'];
        } else if (object.containsKey('place_name')) {
          location.value = object['place_name'];
        } else if (object.containsKey('Placename')) {
          location.value = object['Placename'];
        }
      }
    } else if (widget.postItem.location is String) {
      String locationString = widget.postItem.location;
      if (locationString.isNotEmpty) {
        if (locationString.contains("{")) {
          Map<String, dynamic> locationMap = jsonDecode(locationString);
          if (locationMap.containsKey('description')) {
            location.value = locationMap['description'];
          }
        } else {
          location.value = locationString;
        }
      }
    }
  }

  onPageChanged(int index) {
    currentPage.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.v),
        color: AppColors.mediumDark,
      ),
      margin: EdgeInsets.all(20.v),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15.v),
            child: Row(
              children: [
                // User Avatar
                GestureDetector(
                  onTap: () {
                    // goToUserProfile();
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 5.v, right: 10.v),
                    child: CustomImageView(
                        imagePath: widget.postItem.profilePicture!,
                        radius: BorderRadius.circular(21.v)),
                  ),
                ),

                // User info
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // goToUserProfile();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // User Artist Name
                        Text(
                          widget.postItem.artistName!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: getSupremeStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.light,
                              fontSize: 17.fSize),
                        ),

                        // Location: if available
                        Visibility(
                          visible: location.value.isNotEmpty,
                          child: Container(
                            margin: EdgeInsets.only(
                              top: 2.v,
                            ),
                            child: Text(
                              location.value,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: getSupremeStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.mediumLight,
                                  fontSize: 13.fSize),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /*// Action Button
                IconButton(
                  onPressed: displayContentCardMenu,
                  icon: FaIcon(FontAwesomeIcons.ellipsis,
                      color: AppColors.light, size: 16.sp),
                )*/
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () {},
            child: (widget.postItem.assets!.length == 1)
                ? Flex(direction: Axis.vertical, children: [
                    VideoWidget(
                        asset: widget.postItem.assets![0],
                        muteAllVideo: widget.muteAllVideo,
                        mute: widget.mute)
                  ])
                : Stack(
                    children: [
                      ExpandablePageView.builder(
                        estimatedPageSize: 350.v,
                        itemCount: widget.postItem.assets!.length,
                        onPageChanged: onPageChanged,
                        itemBuilder: (context, index) {
                          return VideoWidget(
                              asset: widget.postItem.assets![index],
                              muteAllVideo: widget.muteAllVideo,
                              mute: widget.mute);
                        },
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                            margin: EdgeInsets.all(10.v),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.v, vertical: 13.v),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: AppColors.mediumDark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.v),
                              ),
                            ),
                            child: Obx(
                              () => Text(
                                '${currentPage.value}/${widget.postItem.assets!.length}',
                                style: TextStyle(
                                  color: AppColors.darkLight,
                                  fontSize: 12.v,
                                  fontFamily: 'Supreme',
                                  fontWeight: FontWeight.w400,
                                  height: 0.14,
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
