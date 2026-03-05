part of 'video_call_screen.dart';

class VideoCallScreenMobile extends GetView<VideoCallController> {
  const VideoCallScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: Dimensions.verticalSize * 0.4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // _buildControlButton(
              //   icon: Icons.mark_chat_read_outlined,
              //   onTap: () => Get.toNamed(Routes.inboxScreen),
              //   backgroundColor: Colors.white.withOpacity(0.9),
              // ),
              _buildControlButton(
                icon: Icons.cameraswitch,
                onTap: controller.toggleCamera,
                backgroundColor: Colors.white.withOpacity(0.9),
              ),
              Obx(
                    () => _buildControlButton(
                  icon: controller.isMuted.value ? Icons.mic_off : Icons.mic,
                  onTap: controller.toggleMute,
                  backgroundColor: Colors.white.withOpacity(0.9),
                ),
              ),
              // Obx(
              //       () => _buildControlButton(
              //     icon: controller.isCameraFlipped.value
              //         ? Icons.flip_camera_ios
              //         : Icons.flip_camera_android,
              //     onTap: controller.flipCamera,
              //     backgroundColor: Colors.white.withOpacity(0.9),
              //   ),
              // ),
              _buildControlButton(
                icon: Icons.call_end,
                onTap: controller.endCall,
                backgroundColor: Colors.red,
                iconColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
      body:  Stack(
        children: [
          // Remote video view (full screen)
          Positioned.fill(
            child: Obx(
                  () =>
              controller.isRemoteUserJoined.value &&
                  controller.remoteUid != null
                  ? AgoraVideoView(
                controller: VideoViewController.remote(
                  rtcEngine: controller.agoraEngine,
                  canvas: VideoCanvas(uid: controller.remoteUid),
                  connection: RtcConnection(
                    channelId: controller.channelName,
                  ),
                ),
              )
                  : Container(
                color: Colors.grey.shade200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: CustomColors.primary,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Waiting for other user...',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Local video preview (Picture in Picture)
          Positioned(
            top: 60,
            right: 16,
            child: Obx(
                  () => controller.isLocalUserJoined.value
                  ? Container(
                width: 120.w,
                height: 160.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  child: AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: controller.agoraEngine,
                      canvas: const VideoCanvas(uid: 0),
                    ),
                  ),
                ),
              )
                  : SizedBox.shrink(),
            ),
          ),

          // Call duration timer
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: Center(
              child: Obx(
                    () => Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    controller.callDuration.value,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Connection status indicator
          Positioned(
            top: 100,
            left: 16,
            child: Obx(() {
              if (!controller.isConnected.value) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColors.primary.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 12.w,
                        height: 12.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.w,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Connecting...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return SizedBox.shrink();
            }),
          ),
        ],
      ),



    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color backgroundColor,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: CustomColors.borderColor),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor ?? Colors.black87, size: 28.h),
      ),
    );
  }
}
