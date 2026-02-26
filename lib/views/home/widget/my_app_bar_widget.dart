part of '../screen/home_screen.dart';

class MyAppBarWidget extends GetView<HomeController> {
  const MyAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: Dimensions.defaultHorizontalSize,
          vertical: Dimensions.verticalSize * 0.1,
        ),
        child: Row(
          mainAxisAlignment: mainSpaceBet,
          children: [
            CustomLogoWidget(),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.notificationScreen),
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.paddingSize * 0.5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CustomColors.disableColor.withOpacity(0.2),
                      ),
                      shape: BoxShape.circle,
                      color: CustomColors.whiteColor,
                    ),

                    child: Icon(
                      Icons.notifications_active_outlined,
                      color: CustomColors.primary,
                      size: Dimensions.iconSizeLarge,
                    ),
                  ),
                ),
                Space.width.v10,
                Obx(() {
                  final profileController = Get.find<ProfileController>();
                  final isUser = AppStorage.isUser == 'USER';

                  final isLoading = isUser
                      ? profileController.getUserProfileLoading.value
                      : profileController.getDoctorProfileLoading.value;

                  final imageUrl = isUser
                      ? profileController.userProfileModel?.data.profileImage ??
                            ''
                      : profileController
                                .doctorProfileModel
                                ?.data
                                .userId
                                .profileImage ??
                            '';

                  return GestureDetector(
                    onTap: () => Get.find<NavigationController>().goToProfile(),
                    child: isLoading
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              width: 50.h,
                              height: 50.h,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : ProfileAvatarWidget(
                            size: 50.h,
                            imageUrl: imageUrl.isNotEmpty
                                ? imageUrl
                                : "https://raw.githubusercontent.com/ai-py-auto/souce/refs/heads/main/Rectangle%202.png",
                          ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
