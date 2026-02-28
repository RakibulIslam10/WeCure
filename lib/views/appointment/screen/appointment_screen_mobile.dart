part of 'appointment_screen.dart';

class AppointmentScreenMobile extends GetView<AppointmentController> {
  const AppointmentScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Appointment", isBack: false),
      body: SafeArea(
        child: AppStorage.isUser != 'USER' ?  ListView.builder(
          itemCount: 5,
          addRepaintBoundaries: true,
          cacheExtent: 500,
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.defaultHorizontalSize,
            vertical: Dimensions.verticalSize * 0.5,
          ),
          shrinkWrap: true,
          primary: false,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(bottom: Dimensions.heightSize),
            child: RequestCard(
              name: "Luna Kellan",
              service: "Professional cleaning",
              time: "10:30 PM - 11:00 PM",
              status: "23 November",
              buttonTitle: 'Join',
              onTap: () => Get.toNamed(Routes.videoCallScreen),

              cardOnTap: () {
                Get.toNamed(Routes.appointmentDetailsScreen);
              },
            ),
          ),
        ) :


        ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.defaultHorizontalSize,
            vertical: Dimensions.verticalSize,
          ),
          itemCount: controller.statusList.length,
          addRepaintBoundaries: true,
          cacheExtent: 500,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final status = controller.statusList[index];
            return AppointmentCard(
              doctorName: 'Dr. Elowyn Starcrest',
              specialization: 'Dentist',
              time: '10:30 PM - 11:00 PM',
              onPressed: () {
                if (status == 'cancelled') {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => BottomSheetDialogWidget(
                      title: 'Delete',
                      subTitle:
                          'are you sure you want to delete this appointment',
                      isLoading: false.obs,
                      action: () {},
                    ),
                  );
                }
                if (status == 'ongoing') {
                  Get.toNamed(Routes.videoCallScreen);
                }
                if (status == 'completed') {
                  Get.toNamed(Routes.inboxScreen);
                }
              },
              status: status,
            );
          },
        ),
      ),
    );
  }
}
