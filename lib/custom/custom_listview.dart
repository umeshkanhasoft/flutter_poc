import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/custom/enum/custom_enum.dart';
import 'package:test_22_10_2024/model/post_model.dart';
import 'package:test_22_10_2024/model/user.dart';
import 'package:test_22_10_2024/service/api_client.dart';
import 'package:test_22_10_2024/service/base_response.dart';
import 'package:test_22_10_2024/utils/app_logs.dart';
import 'package:test_22_10_2024/widget/list_cell/battle_vote_cell.dart';
import 'package:test_22_10_2024/widget/list_cell/follower_cell.dart';
import 'package:test_22_10_2024/widget/list_cell/feed_cell/feed_cell.dart';
import 'package:test_22_10_2024/widget/loader.dart';

class CustomListview extends StatefulWidget {
  final RxList contents;
  final bool? isPagination;
  final bool? isShowGrid;
  final CustomCellListview type;
  final CustomApiRequestClass customApiRequestClass;
  final int perPage;
  final Widget emptyWidget;

  const CustomListview(
      {super.key,
      required this.contents,
      required this.isPagination,
      required this.type,
      required this.customApiRequestClass,
      required this.emptyWidget,
      this.isShowGrid = false,
      this.perPage = 50});

  @override
  State<CustomListview> createState() => _CustomListviewState();
}

class _CustomListviewState extends State<CustomListview> {
  ScrollController scrollController = ScrollController();
  var currentPage = 1.obs;
  var isApiLoading = false.obs;
  RxBool muteAllVideo = false.obs;

  @override
  void initState() {
    super.initState();
    pagination();
  }

  void pagination() {
    callApiForAllListview();
    if (widget.isPagination == true) {
      scrollController.addListener(() {
        if (scrollController.position.atEdge) {
          bool isTop = scrollController.position.pixels == 0;
          if (!isTop) {
            currentPage.value = currentPage.value + 1;
            callApiForAllListview();
          }
        }
      });
    }
  }

  Future callApiForAllListview() async {
    try {
      Map<String, dynamic> requestQueryParam = widget.isPagination == true
          ? (widget.customApiRequestClass.queryParam
            ..addAll({"page": currentPage.value, "per_page": widget.perPage}))
          : widget.customApiRequestClass.queryParam;
      isApiLoading.value = true;
      ApiResponse? response = await ApiClient.instance.call(
        url: widget.customApiRequestClass.url,
        method: widget.customApiRequestClass.method,
        queryParams: requestQueryParam,
        param: widget.customApiRequestClass.dataParam,
      );
      isApiLoading.value = false;
      if (response is DataResponse) {
        if (response.status == true) {
          if (response.data != null) {
            if (response.data is List && response.data.isNotEmpty) {
              addValueInArray(response.data);
            }
          }
        }
      }
    } catch (e) {
      appLogs("<><>$e");
      //nothing to do
    }
  }

  addValueInArray(List<dynamic> data) {
    if (currentPage.value == 1) {
      widget.contents.clear();
    }
    switch (widget.type) {
      case CustomCellListview.homeFeed:
        // do for home
        widget.contents.addAll(data.map((e) => Post.fromJson(e)).toList());
        widget.contents.removeWhere((element) => element == null);
      case CustomCellListview.followers:
      case CustomCellListview.following:
        widget.contents.addAll(data.map((e) => Users.fromJson(e)).toList());
      case CustomCellListview.voteList:
    }
  }

  Widget buildLoaderView() {
    return const Center(
      child: LoaderOverlay(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (currentPage.value == 1 && isApiLoading.value)
          ? buildLoaderView()
          : widget.isShowGrid == true
              ? StaggeredGrid.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  children: List.generate(
                      widget.contents.length + (isApiLoading.value ? 1 : 0),
                      (index) {
                    return StaggeredGridTile.count(
                      crossAxisCellCount: index == 0 ? 2 : 1,
                      mainAxisCellCount: index == 0 ? 2 : 1,
                      child: widget.contents.isEmpty == true
                          ? widget.emptyWidget
                          : index == widget.contents.length
                              ? buildLoaderView()
                              : getWidgetFromType(widget.contents[index]),
                    );
                  }))
              : ListView.builder(
                  itemCount:
                      widget.contents.length + (isApiLoading.value ? 1 : 0),
                  shrinkWrap: true,
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    return widget.contents.isEmpty == true
                        ? widget.emptyWidget
                        : index == widget.contents.length
                            ? buildLoaderView()
                            : getWidgetFromType(widget.contents[index]);
                  },
                ),
    );
  }

  Widget getWidgetFromType(dynamic item) {
    switch (widget.type) {
      case CustomCellListview.homeFeed:
        return FeedCell(
            postItem: item,
            muteAllVideo: muteAllVideo,
            mute: (value) {
              muteAllVideo.value = value;
            });
      case CustomCellListview.followers:
      case CustomCellListview.following:
        return FollowerCell(item: item as Users, type: widget.type);
      case CustomCellListview.voteList:
        return BattleVoteCell(item: item);
    }
  }
}
