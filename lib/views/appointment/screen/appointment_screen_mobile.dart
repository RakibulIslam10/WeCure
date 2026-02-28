part of 'appointment_screen.dart';

class AppointmentScreenMobile extends GetView<AppointmentController> {
  const AppointmentScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Appointment", isBack: false),
      body: SafeArea(
        child: RefreshIndicator(
          color: CustomColors.primary,
          backgroundColor: CustomColors.whiteColor,
          onRefresh: () async {
            if (AppStorage.isUser == 'USER') controller.fetchUserAppointments();
          },
          child: Obx(() {
            if (AppStorage.isUser != 'USER') {
              return ListView.builder(
                itemCount: 5,
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.defaultHorizontalSize,
                  vertical: Dimensions.verticalSize * 0.5,
                ),
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
              );
            }

            if (controller.isLoading.value) {
              return LoadingWidget();
            }

            final appointments = controller.userAppointments.value;

            if (appointments == null || appointments.data.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: mainCenter,
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 80.h,
                      color: CustomColors.grayShade,
                    ),
                    Space.height.v20,
                    TextWidget(
                      'No appointments found',
                      fontSize: Dimensions.titleMedium,
                      color: CustomColors.grayShade,
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.defaultHorizontalSize,
                vertical: Dimensions.verticalSize,
              ),
              itemCount: appointments.data.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final appointment = appointments.data[index];

                final startTime = DateFormat(
                  'HH:mm',
                ).parse(appointment.appointmentTime);
                final endTime = DateFormat(
                  'HH:mm',
                ).parse(appointment.appointmentEndTime);

                return AppointmentCard(
                  appointmentId: appointment.id,
                  doctorName: appointment.doctorName,
                  specialization: appointment.specialtyName,
                  time:
                      '${DateFormat('HH:mm').format(startTime)} - ${DateFormat('HH:mm').format(endTime)}',
                  date: DateFormat(
                    'dd MMM yyyy',
                  ).format(appointment.appointmentDate.toLocal()),
                  status: appointment.status.toLowerCase(),
                  onPressed: () =>
                      controller.handleAppointmentAction(appointment),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
