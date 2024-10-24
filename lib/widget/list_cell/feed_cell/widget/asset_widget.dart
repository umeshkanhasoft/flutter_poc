import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_22_10_2024/model/post_model.dart';
import 'package:test_22_10_2024/utils/colors.dart';
import 'package:test_22_10_2024/utils/size_utils.dart';
import 'package:test_22_10_2024/widget/empty_widget.dart';
import 'package:test_22_10_2024/widget/loader.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoWidget extends StatefulWidget {
  final AssetModel asset;
  final RxBool muteAllVideo;
  final Function(bool mute)? mute;

  const VideoWidget(
      {super.key,
      required this.asset,
      required this.mute,
      required this.muteAllVideo});

  @override
  VideoWidgetState createState() => VideoWidgetState();
}

class VideoWidgetState extends State<VideoWidget>
    with SingleTickerProviderStateMixin {
  VideoPlayerController? controller;

  RxBool isVideoInitialize = false.obs;
  RxBool isPlaying = false.obs;
  RxBool isPlayingError = false.obs;

  late AnimationController animationController;
  late Animation<double> _animation;

  List<VideoPlayerController?> allPlayers = [];

  @override
  void initState() {
    super.initState();
    if (widget.asset.contentType == 'video') {
      controller = VideoPlayerController.networkUrl(
          Uri.parse(widget.asset.url.toString()))
        ..addListener(() {
          isPlayingError.value = controller!.value.hasError;
          if (controller?.value.position == controller?.value.duration) {
            // Restart the video
            controller?.seekTo(Duration.zero);
            controller?.play();
          }
        })
        ..initialize().then((_) {
          isVideoInitialize.value = true; // Keep track of all player instances
        })
        ..setVolume(widget.muteAllVideo.value ? 0 : 1);
      allPlayers.add(controller!);
      animationController = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      );

      _animation =
          Tween<double>(begin: 1.5, end: 1.8).animate(animationController);
    } else {
      allPlayers.add(null);
    }
  }

  @override
  void dispose() {
    if (widget.asset.contentType == 'video') {
      controller?.dispose();
      animationController.dispose();
      allPlayers.remove(controller); // Remove on disposal
    }
    super.dispose();
  }

  void togglePlayPause() {
    if (isPlaying.value) {
      pauseVideo();
      animationController.reverse();
    } else {
      playVideo();
      animationController.forward();
    }
  }

  void _retryVideo() {
    isPlayingError.value = false;
    controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.asset.url.toString()))
          ..addListener(() => isPlayingError.value = controller!.value.hasError)
          ..initialize().then((_) {
            isVideoInitialize.value = true;
          });
  }

  void playVideo() {
    try {
      if (controller?.value.isInitialized == true) {
        controller?.setVolume(widget.muteAllVideo.value ? 0 : 1);
      }
      if (controller != null && !isPlaying.value) {
        controller?.play();
        isPlaying.value = true;
      }
    } catch (e) {
      //nothing to do
    }
  }

  void pauseVideo() {
    try {
      if (controller?.value.isInitialized == true) {
        controller?.setVolume(widget.muteAllVideo.value ? 0 : 1);
      }
      if (controller != null && isPlaying.value) {
        controller?.pause();
        isPlaying.value = false;
      }
    } catch (e) {
      //nothing to do
    }
  }

  void toggleMute() {
    widget.muteAllVideo.value = !widget.muteAllVideo.value;
    widget.mute!(widget.muteAllVideo.value);
    controller?.setVolume(widget.muteAllVideo.value ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.asset.url.toString()), // Unique key for each asset
      onVisibilityChanged: (visibilityInfo) {
        final visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 30) {
          // Play video if more than 50% visible
          try {
            playVideo();
          } catch (e) {
            //nothing to do
          }
        } else {
          try {
            pauseVideo();
          } catch (e) {
            //nothing to do
          }
        }
      },
      child: (widget.asset.contentType == 'image')
          ? loadImage(widget.asset.thumbnail.toString())
          : Obx(
              () => controller != null && isVideoInitialize.value
                  ? loadVideoView()
                  : isPlayingError.value
                      ? videoErrorWidget()
                      : loadImage(widget.asset.thumbnail.toString(),
                          isFromVideo: true),
            ),
    );
  }

  loadVideoView() {
    return Stack(
      children: [
        GestureDetector(
          onTap: togglePlayPause,
          child: AspectRatio(
            aspectRatio: controller!.value.aspectRatio,
            child: VideoPlayer(controller!),
          ),
        ),

        // Animated Play/Pause Button
        Positioned(
          top: 20.v,
          right: 10.v,
          child: GestureDetector(
            onTap: togglePlayPause,
            child: ScaleTransition(
              scale: _animation,
              child: Obx(
                () => Icon(
                  isPlaying.value ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 20.v,
                ),
              ),
            ),
          ),
        ),

        Positioned(
          top: 70.v,
          right: 10.v,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: toggleMute,
            child: ScaleTransition(
              scale: _animation,
              child: Obx(
                () => Icon(
                  widget.muteAllVideo.value
                      ? Icons.volume_off
                      : Icons.volume_up,
                  color: Colors.white,
                  size: 20.v,
                ),
              ),
            ),
          ),
        ), // Show overlay when paused
      ],
    );
  }

  Widget loadImage(String url, {bool isFromVideo = false}) {
    return Stack(
      children: [
        CachedNetworkImage(
          key: ValueKey(url),
          errorListener: (_) {},
          fit: BoxFit.cover,
          imageUrl: url,
          placeholder: (context, url) => SizedBox(
            height: 400.v,
            width: double.infinity,
            child: LinearProgressIndicator(
              color: Colors.grey.shade200,
              backgroundColor: Colors.grey.shade100,
            ),
          ),
          errorWidget: (context, url, error) => Center(
            child: Text(
              "Failed to load video",
              style: getSupremeStyle(
                  fontSize: 13.fSize,
                  fontWeight: FontWeight.w400,
                  color: AppColors.light),
            ),
          ),
        ),
        isFromVideo == true
            ? const Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: LoaderOverlay(),
                ))
            : Container()
      ],
    );
  }

  videoErrorWidget() {
    return Container(
      width: double.infinity,
      height: 400.v,
      color: AppColors.mediumDark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50.v,
            width: 50.v,
            child: IconButton(
              color: AppColors.mediumLight,
              icon: const Icon(Icons.refresh_outlined),
              onPressed: _retryVideo,
              // child: Text('Retry'),
            ),
          ),
          Text(
            "Failed to load video",
            style: getSupremeStyle(
                fontSize: 13.fSize,
                fontWeight: FontWeight.w400,
                color: AppColors.light),
          )
        ],
      ),
    );
  }
}
