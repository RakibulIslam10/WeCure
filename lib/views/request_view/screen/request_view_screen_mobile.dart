part of 'request_view_screen.dart';

class RequestViewScreenMobile extends GetView<DoctorHomeController> {
  const RequestViewScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Appointment Request", isBack: false),
      body: SafeArea(
        child: Obx(() {
          final appointments =
              controller.dashboardModel.value?.data.upcomingAppointments ?? [];

          if (appointments.isEmpty) {
            return Center(
              child: TextWidget(
                'No appointment requests found',
                color: CustomColors.grayShade,
                fontSize: Dimensions.titleSmall,
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.defaultHorizontalSize,
            ),
            itemCount: appointments.length,
            addRepaintBoundaries: true,
            cacheExtent: 500,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return Padding(
                padding: EdgeInsets.only(bottom: Dimensions.heightSize),
                child: RequestCard(
                  name: appointment.patientName,
                  service: appointment.reasonTitle,
                  time: appointment.timeRange,
                  status: DateFormat(
                    "dd MMMM yyyy",
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
          );
        }),
      ),
    );
  }
}
