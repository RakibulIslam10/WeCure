part of 'appointment_screen.dart';

class AppointmentScreenMobile extends GetView<AppointmentController> {
  const AppointmentScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final isUser = AppStorage.isUser == 'USER';

    return Scaffold(
      appBar: CommonAppBar(title: "Appointment", isBack: false),
      body: SafeArea(
        child: RefreshIndicator(
          color: CustomColors.primary,
          backgroundColor: CustomColors.whiteColor,
          onRefresh: () async {
            if (isUser) {
              await controller.fetchUserAppointments();
            } else {
              await controller.fetchDoctorAppointments();
            }
          },
          child: Obx(() {

            /// ================= USER =================
            if (isUser) {

              if (controller.isUserLoading.value) {
                return LoadingWidget();
              }
              final appointments = controller.userAppointments.value?.data ?? [];
              if (appointments.isEmpty) {
                return _emptyWidget();
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.defaultHorizontalSize,
                  vertical: Dimensions.verticalSize,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: appointments.length,
                itemBuilder: (context, index) {

                  final appointment = appointments[index];

                  final startTime = DateFormat('HH:mm')
                      .parse(appointment.appointmentTime ?? '00:00');

                  final endTime = DateFormat('HH:mm')
                      .parse(appointment.appointmentEndTime ?? '00:00');

                  return AppointmentCard(
                    appointmentId: appointment.id,
                    doctorName: appointment.doctorName,
                    specialization: appointment.specialtyName,
                    time:
                    '${DateFormat('HH:mm').format(startTime)} - ${DateFormat('HH:mm').format(endTime)}',
                    date: DateFormat('dd MMM yyyy')
                        .format(appointment.appointmentDate.toLocal()),
                    status: appointment.status.toLowerCase() ?? '',
                    onPressed: () =>
                        controller.handleAppointmentAction(appointment),
                  );
                },
              );
            }

            /// ================= DOCTOR =================
            if (controller.isDoctorLoading.value) {
              return LoadingWidget();
            }

            final appointments =
                controller.doctorAppointments.value?.data ?? [];

            if (appointments.isEmpty) {
              return _emptyWidget();
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.defaultHorizontalSize,
                vertical: Dimensions.verticalSize,
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: appointments.length,
              itemBuilder: (context, index) {

                final appointment = appointments[index];

                final startTime = DateFormat('HH:mm')
                    .parse(appointment.appointmentTime);

                final endTime = DateFormat('HH:mm')
                    .parse(appointment.appointmentEndTime);

                return

                //   RequestCard(
                //   name: appointment.patientName,
                //   service: appointment.specialtyName,
                //   time: '${DateFormat('HH:mm').format(startTime)} - ${DateFormat('HH:mm').format(endTime)}',
                //   status: DateFormat('dd MMM yyyy')
                //       .format(appointment.appointmentDate.toLocal()),
                //   buttonTitle: appointment.status == 'ONGOING' ? 'Join' : appointment.status == 'CANCELLED' ? 'Cancelled' : 'Chat',
                //   onTap: () =>
                //       controller.handleAppointmentAction(appointment),
                //   cardOnTap: () {
                //     Get.toNamed(Routes.appointmentDetailsScreen);
                //   },
                // );

                  AppointmentCard(
                    appointmentId: appointment.id,
                    doctorName: appointment.patientName,
                    specialization: appointment.specialtyName,
                    time:
                    '${DateFormat('HH:mm').format(startTime)} - ${DateFormat('HH:mm').format(endTime)}',
                    date: DateFormat('dd MMM yyyy')
                        .format(appointment.appointmentDate.toLocal()),
                    status: appointment.status.toLowerCase() ?? '',
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

  Widget _emptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
}