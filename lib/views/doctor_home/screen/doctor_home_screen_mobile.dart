part of 'doctor_home_screen.dart';

class DoctorHomeScreenMobile extends GetView<DoctorHomeController> {
  const DoctorHomeScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        flexibleSpace: const MyAppBarWidget(),
      ),
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? LoadingWidget()
              : RefreshIndicator(
                  color: CustomColors.primary,
                  backgroundColor: CustomColors.whiteColor,
                  onRefresh: () async {
                    controller.fetchDashboard();
                  },
                  child: ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
                    children: [
                      Space.height.v20,
                      const DoctorAppointmentSectionWidget(),
                      Space.height.v20,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.defaultHorizontalSize,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius,
                          ),
                          border: Border.all(color: CustomColors.borderColor),
                        ),
                        child: Row(
                          mainAxisAlignment: mainSpaceBet,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    Dimensions.defaultHorizontalSize * 0.5,
                                vertical: Dimensions.verticalSize * 0.5,
                              ),
                              child: Column(
                                crossAxisAlignment: crossStart,
                                children: [
                                  TextWidget(
                                    "Booking Request",
                                    color: CustomColors.grayShade,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  TextWidget(
                                    '${controller.dashboardModel.value?.data.stats.bookingRequestCount ?? 0}',
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 60.h,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    Dimensions.defaultHorizontalSize * 0.5,
                                vertical: Dimensions.verticalSize * 0.5,
                              ),
                              child: Column(
                                crossAxisAlignment: crossEnd,
                                children: [
                                  TextWidget(
                                    "Accepted",
                                    color: CustomColors.grayShade,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  TextWidget(
                                    '${controller.dashboardModel.value?.data.stats.acceptedCount ?? 0}',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Space.height.v20,

                      // ListView.builder(
                      //   itemCount:
                      //       controller
                      //           .dashboardModel
                      //           .value
                      //           ?.data
                      //           .upcomingAppointments
                      //           .length ??
                      //       0,
                      //   addRepaintBoundaries: true,
                      //   cacheExtent: 500,
                      //   shrinkWrap: true,
                      //   primary: false,
                      //   physics: NeverScrollableScrollPhysics(),
                      //   itemBuilder: (context, index) {
                      //     final appointment = controller
                      //         .dashboardModel
                      //         .value!
                      //         .data
                      //         .upcomingAppointments[index];
                      //     return Padding(
                      //       padding: EdgeInsets.only(
                      //         bottom: Dimensions.heightSize,
                      //       ),
                      //       child: RequestCard(
                      //         name: appointment.patientName,
                      //         service: appointment.reasonTitle,
                      //         time: appointment.timeRange,
                      //         status: DateFormat(
                      //           "dd MMMM",
                      //         ).format(DateTime.parse(appointment.date)),
                      //         buttonTitle: 'View',
                      //         cardOnTap: () {
                      //           Get.toNamed(Routes.appointmentDetailsScreen);
                      //         },
                      //       ),
                      //     );
                      //   },
                      // ),
                      if ((controller
                                  .dashboardModel
                                  .value
                                  ?.data
                                  .upcomingAppointments
                                  .length ??
                              0) ==
                          0)
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: Dimensions.heightSize * 5,
                            ),
                            child: TextWidget(
                              'No upcoming appointments',
                              color: CustomColors.grayShade,
                              fontSize: Dimensions.titleSmall,
                            ),
                          ),
                        )
                      else
                        ListView.builder(
                          itemCount: controller
                              .dashboardModel
                              .value!
                              .data
                              .upcomingAppointments
                              .length,
                          addRepaintBoundaries: true,
                          cacheExtent: 500,
                          shrinkWrap: true,
                          primary: false,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final appointment = controller
                                .dashboardModel
                                .value!
                                .data
                                .upcomingAppointments[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: Dimensions.heightSize,
                              ),
                              child: RequestCard(
                                name: appointment.patientName,
                                service: appointment.reasonTitle,
                                time: appointment.timeRange,
                                status: DateFormat(
                                  "dd MMMM",
                                ).format(DateTime.parse(appointment.date)),
                                buttonTitle: 'View',
                                cardOnTap: () {
                                  Get.toNamed(
                                    Routes.appointmentDetailsScreen,
                                    arguments: appointment.id,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
