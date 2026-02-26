part of 'profile_screen.dart';

class ProfileScreenMobile extends GetView<ProfileController> {
  const ProfileScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Profile", isBack: false),
      body: SafeArea(
        child: Obx(
          () => controller.getDoctorProfileLoading.value || controller.getUserProfileLoading.value
              ? LoadingWidget()
              : RefreshIndicator(
                  color: CustomColors.primary,
                  backgroundColor: CustomColors.whiteColor,
                  onRefresh: () async {
                    controller.getDoctorProfile();
                  },
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
                    children: [
                      if (AppStorage.isUser == 'USER') ProfileBoxWidget(),
                      if (AppStorage.isUser == 'DOCTOR') DoctorProfileBox(),

                      Space.height.v40,
                      Column(
                        children: List.generate(
                          5,
                          (index) => GestureDetector(
                            onTap: () {
                              controller.profileList[index]['onTap'] != null
                                  ? Get.toNamed(
                                      controller.profileList[index]['onTap'],
                                    )
                                  : showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          BottomSheetDialogWidget(
                                            title: "Logout",
                                            subTitle:
                                                'Are you sure you want to logout?',
                                            isLoading: controller.isLoading,
                                            action: () {
                                              controller.logoutProcess();
                                            },
                                          ),
                                    );
                            },
                            child: Container(
                              margin: EdgeInsetsGeometry.only(
                                bottom: Dimensions.heightSize * 1.5,
                              ),
                              padding: EdgeInsetsGeometry.symmetric(
                                horizontal: Dimensions.defaultHorizontalSize,
                                vertical: Dimensions.verticalSize * 0.6,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radius,
                                ),
                                border: Border.all(
                                  color: CustomColors.borderColor,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: mainSpaceBet,
                                children: [
                                  Wrap(
                                    spacing: Dimensions.widthSize,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      Icon(
                                        controller.profileList[index]['icon'],
                                        color:
                                            controller
                                                    .profileList[index]['title'] ==
                                                'Logout'
                                            ? Colors.red
                                            : CustomColors.primary,
                                      ),

                                      TextWidget(
                                        controller.profileList[index]['title'],
                                      ),
                                    ],
                                  ),

                                  Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: CustomColors.primary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
