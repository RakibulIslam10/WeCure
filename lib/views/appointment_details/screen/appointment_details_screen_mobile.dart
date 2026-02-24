part of 'appointment_details_screen.dart';

class AppointmentDetailsScreenMobile
    extends GetView<AppointmentDetailsController> {
  const AppointmentDetailsScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.defaultHorizontalSize,
            vertical: Dimensions.verticalSize * 0.5
          ),
          child: Column(
            mainAxisSize: mainMin,
            children: [
              Row(
                children: [
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
                            subTitle: 'write a reason for rejecting the appointment request',
                            isLoading: false.obs,
                            buttonTex: 'Reject',
                            action: () {},
                          ),
                        );
                      },
                      title: 'Reject  Appointment',
                    ),
                  ),
                  Space.width.v10,
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.inboxScreen),
                    child: Container(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: Dimensions.defaultHorizontalSize,
                        vertical: Dimensions.verticalSize * 0.55,
                      ),
                      decoration: BoxDecoration(
                        color: CustomColors.primary,
                        borderRadius: BorderRadius.circular(Dimensions.radius),
                      ),
              
                      child: TextWidget("Chat", color: CustomColors.whiteColor),
                    ),
                  ),
                ],
              ),
              // if(AppStorage.isUser != 'USER')...[
              //   Space.height.v15,
              //   PrimaryButtonWidget(title: "Accept Request", onPressed: () {},),
              // ]
            ],
          ),
        ),
      ),

      appBar: CommonAppBar(title: "Details"),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          physics: BouncingScrollPhysics(),
          children: [
            Space.height.v15,


            if(AppStorage.isUser == 'USER')  DoctorDetailsCard(
              imageUrl:
              'https://raw.githubusercontent.com/ai-py-auto/souce/refs/heads/main/Rectangle%202.png',
              name: 'Dr. Elowyn Starcrest',
              specialty: 'Dentist',
              clinicName: 'Central Dental Care',
              rating: 4.7,
              yearsOfExperience: 12,
              startingPrice: 10,
              onTap: () {},
            ),
            if(AppStorage.isUser != 'USER') PatientInfoWidgetWithAsset(
              patientImageNetwork: 'https://raw.githubusercontent.com/ai-py-auto/souce/refs/heads/main/Rectangle%202.png',
              patientName: 'Luna Kellan',
              dateOfBirth: '10- Aug-1986',
              phoneNumber: '+1263565 36565',
              bloodGroup: 'A+',
              allergies: [
                'Food Allergies',
                'Seasonal Allergies',
                'Pet Allergies',
                'Insect Sting Allergies',
              ],
            ),


            TextWidget(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: Dimensions.verticalSize,
              ),
              'Appointment Details',
            ),

            InfoPairRow(
              leftTitle: 'Visit reason',
              leftValue: 'Professional cleaning',
              rightTitle: 'Booking Date',
              rightValue: '7 November',
            ),
            Space.height.v15,

            TextWidget(
              padding: EdgeInsetsGeometry.only(
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
              '''
              the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.
              ''',
            ),

            Space.height.v15,

            InfoPairRow(
              leftTitle: 'Visiting Date',
              leftValue: '21 November\n6:30 PM',
              rightTitle: 'Status',
              rightValue: 'Pending',
            ),
            Space.height.v15,

            TextWidget("Appointment Fee", fontWeight: FontWeight.w400),
            TextWidget("\$12", fontWeight: FontWeight.bold),
            Space.height.v15,

            TextWidget(
              padding: EdgeInsetsGeometry.only(bottom: Dimensions.heightSize),
              "Attachment",
              fontWeight: FontWeight.bold,
            ),
            Wrap(
              children: List.generate(
                3,
                (index) => Container(
                  height: 100.h,
                  width: 100.w,
                  margin: EdgeInsets.only(right: Dimensions.widthSize),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CustomColors.grayShade.withOpacity(0.7),
                    ),
                    borderRadius: BorderRadius.circular(Dimensions.radius),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.radius),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqGVGf1MbRIenHlupz_bqCZCCzq0zH9sS0BQ&s',
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
        ),
      ),
    );
  }
}
