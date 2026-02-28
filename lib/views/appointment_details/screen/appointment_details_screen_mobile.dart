part of 'appointment_details_screen.dart';

class AppointmentDetailsScreenMobile
    extends GetView<AppointmentDetailsController> {
  const AppointmentDetailsScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final appointmentData = controller.userAppointmentDetailsModel.value;
    final status = appointmentData?.data.status;
    return Scaffold(
      bottomNavigationBar: Obx(
        () => controller.isLoading.value
            ? SizedBox.shrink()
            : SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.defaultHorizontalSize,
                    vertical: Dimensions.verticalSize * 0.5,
                  ),
                  child: Column(
                    mainAxisSize: mainMin,
                    children: [
                      Row(
                        children: [
                          if (AppStorage.isUser != 'USER') ...[
                            Expanded(
                              child: PrimaryButtonWidget(
                                outlineButton: true,
                                buttonTextColor: CustomColors.rejected,
                                borderColor: CustomColors.rejected,
                                borderWidth: 1.5,
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => BottomSheetDialogWidget(
                                      titleColor: CustomColors.rejected,
                                      isInputField: true,
                                      title: 'Reject Request',
                                      inputController:
                                          controller.reasonController,
                                      subTitle:
                                          'write a reason for rejecting the appointment request',
                                      isLoading: controller.isDeleting,
                                      buttonTex: 'Reject',
                                      action: () {
                                        controller.rejectAppointment();
                                      },
                                    ),
                                  );
                                },
                                title: 'Reject Appointment',
                              ),
                            ),
                            Space.width.v10,
                          ],
                          Expanded(
                            child: GestureDetector(
                              onTap: status == 'CANCELLED'
                                  ? () {}
                                  : status == 'UPCOMING'
                                  ? () => Get.toNamed(Routes.videoCallScreen)
                                  : () => Get.toNamed(Routes.inboxScreen),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      Dimensions.defaultHorizontalSize * 0.5,
                                  vertical: Dimensions.verticalSize * 0.55,
                                ),
                                decoration: BoxDecoration(
                                  color: CustomColors.primary,
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.radius,
                                  ),
                                ),
                                child: Center(
                                  child: TextWidget(
                                    status == 'CANCELLED'
                                        ? "Cancelled"
                                        : status == 'UPCOMING'
                                        ? 'Join'
                                        : 'Chat',
                                    color: CustomColors.whiteColor,
                                    fontSize: Dimensions.titleMedium,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
      appBar: CommonAppBar(title: "Details"),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return LoadingWidget();
          }

          // ✅ Check user type and load appropriate data
          if (AppStorage.isUser == 'USER') {
            // 👤 USER: Show doctor info
            final appointmentData =
                controller.userAppointmentDetailsModel.value;
            if (appointmentData == null) {
              return Center(
                child: TextWidget(
                  'No data available',
                  fontSize: Dimensions.titleMedium,
                ),
              );
            }

            final doctor = appointmentData.data.doctorInfo;
            final data = appointmentData.data;

            return ListView(
              padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
              physics: BouncingScrollPhysics(),
              children: [
                Space.height.v15,

                // ✅ Doctor Card
                DoctorDetailsCard(
                  imageUrl: doctor.profileImage,
                  name: doctor.name,
                  specialty: doctor.specialty,
                  clinicName: doctor.organization,
                  rating: doctor.rating.toDouble(),
                  yearsOfExperience: doctor.experienceYears,
                  startingPrice: data.consultationFee.toDouble(),
                  onTap: () {},
                ),

                TextWidget(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.verticalSize,
                  ),
                  'Appointment Details',
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.titleMedium,
                ),

                InfoPairRow(
                  leftTitle: 'Reason',
                  leftValue: data.reasonTitle,
                  rightTitle: 'Booking Date',
                  rightValue: DateFormat(
                    "dd MMM yyyy",
                  ).format(data.appointmentDate.toLocal()),
                ),
                Space.height.v15,

                TextWidget(
                  padding: EdgeInsets.only(
                    top: Dimensions.heightSize,
                    bottom: Dimensions.heightSize * 0.5,
                  ),
                  'Details',
                  fontSize: Dimensions.titleSmall,
                  fontWeight: FontWeight.bold,
                ),

                TextWidget(
                  textAlign: TextAlign.justify,
                  fontSize: Dimensions.titleSmall,
                  fontWeight: FontWeight.w400,
                  data.reasonDetails,
                ),

                Space.height.v15,

                InfoPairRow(
                  leftTitle: 'Visiting Date',
                  leftValue:
                      '${DateFormat("dd MMM yyyy").format(data.appointmentDate.toLocal())}\n${data.appointmentTime}',
                  rightTitle: 'Status',
                  rightValue: data.status,
                ),
                Space.height.v15,

                TextWidget("Appointment Fee", fontWeight: FontWeight.w400),
                TextWidget(
                  '₦${data.consultationFee}',
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.titleLarge,
                ),
                Space.height.v15,

                if (data.attachments.isNotEmpty) ...[
                  TextWidget(
                    padding: EdgeInsets.only(bottom: Dimensions.heightSize),
                    "Attachment",
                    fontWeight: FontWeight.bold,
                  ),
                  Wrap(
                    spacing: Dimensions.widthSize,
                    runSpacing: Dimensions.heightSize,
                    children: List.generate(
                      data.attachments.length,
                      (index) => Container(
                        height: 100.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: CustomColors.grayShade.withOpacity(0.7),
                          ),
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: data.attachments[index].url,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Icon(
                              Icons.image_not_supported,
                              color: CustomColors.grayShade,
                              size: Dimensions.iconSizeLarge,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            );
          } else {
            // 👨‍⚕️ DOCTOR: Show patient info
            final appointmentData =
                controller.doctorAppointmentDetailsModel.value;
            if (appointmentData == null) {
              return Center(
                child: TextWidget(
                  'No data available',
                  fontSize: Dimensions.titleMedium,
                ),
              );
            }

            final patient = appointmentData.data.patient;
            final data = appointmentData.data;

            return ListView(
              padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
              physics: BouncingScrollPhysics(),
              children: [
                Space.height.v15,

                // ✅ Patient Info
                PatientInfoWidgetWithAsset(
                  patientImageNetwork: patient.profileImage,
                  patientName: patient.name,
                  dateOfBirth: DateFormat(
                    "dd MMM yyyy",
                  ).format(patient.dateOfBirth.toLocal()),
                  phoneNumber: patient.phone,
                  bloodGroup: patient.bloodGroup,
                  allergies: patient.allergies.isNotEmpty
                      ? patient.allergies
                      : ['None'],
                ),

                TextWidget(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.verticalSize,
                  ),
                  'Appointment Details',
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.titleMedium,
                ),

                InfoPairRow(
                  leftTitle: 'Reason',
                  leftValue: data.reasonTitle,
                  rightTitle: 'Booking Date',
                  rightValue: DateFormat(
                    "dd MMM yyyy",
                  ).format(data.appointmentDate.toLocal()),
                ),
                Space.height.v15,

                TextWidget(
                  padding: EdgeInsets.only(
                    top: Dimensions.heightSize,
                    bottom: Dimensions.heightSize * 0.5,
                  ),
                  'Details',
                  fontSize: Dimensions.titleSmall,
                  fontWeight: FontWeight.bold,
                ),

                TextWidget(
                  textAlign: TextAlign.justify,
                  fontSize: Dimensions.titleSmall,
                  fontWeight: FontWeight.w400,
                  data.reasonDetails,
                ),

                Space.height.v15,

                InfoPairRow(
                  leftTitle: 'Visiting Date',
                  leftValue:
                      '${DateFormat("dd MMM yyyy").format(data.appointmentDate.toLocal())}\n${data.appointmentTime}',
                  rightTitle: 'Status',
                  rightValue: data.status,
                ),
                Space.height.v15,

                TextWidget("Appointment Fee", fontWeight: FontWeight.w400),
                TextWidget(
                  '₦${data.consultationFee}',
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.titleLarge,
                ),
                Space.height.v15,

                if (data.attachments.isNotEmpty) ...[
                  TextWidget(
                    padding: EdgeInsets.only(bottom: Dimensions.heightSize),
                    "Attachment",
                    fontWeight: FontWeight.bold,
                  ),
                  Wrap(
                    spacing: Dimensions.widthSize,
                    runSpacing: Dimensions.heightSize,
                    children: List.generate(
                      data.attachments.length,
                      (index) => Container(
                        height: 100.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: CustomColors.grayShade.withOpacity(0.7),
                          ),
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: data.attachments[index].url,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Icon(
                              Icons.image_not_supported,
                              color: CustomColors.grayShade,
                              size: Dimensions.iconSizeLarge,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            );
          }
        }),
      ),
    );
  }
}
