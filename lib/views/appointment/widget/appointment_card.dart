import '../../../core/utils/basic_import.dart';

class AppointmentCard extends StatelessWidget {
  final String appointmentId;
  final String doctorName;
  final String specialization;
  final String time;
  final String date;
  final String status;
  final VoidCallback? onPressed;

  const AppointmentCard({
    super.key,
    required this.appointmentId,
    required this.doctorName,
    required this.specialization,
    required this.time,
    required this.date,
    required this.status,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isCancelled = status.toLowerCase() == 'cancelled';
    final isOngoing = status.toLowerCase() == 'ongoing';

    return GestureDetector(
      onTap: () => Get.toNamed(
        Routes.appointmentDetailsScreen,
        arguments: appointmentId,
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: Dimensions.heightSize * 1.2),
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.defaultHorizontalSize,
          vertical: Dimensions.verticalSize * 0.6,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
          border: Border.all(
            color: CustomColors.grayShade.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: crossStart,
                children: [
                  TextWidget(
                    doctorName,
                    fontSize: Dimensions.titleMedium,
                    fontWeight: FontWeight.bold,
                  ),
                  Space.height.v5,
                  TextWidget(
                    specialization,
                    fontSize: Dimensions.titleSmall,
                    fontWeight: FontWeight.w500,
                    color: CustomColors.grayShade,
                  ),
                  Space.height.v10,
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: Dimensions.iconSizeDefault,
                        color: CustomColors.grayShade,
                      ),
                      Space.width.v5,
                      TextWidget(
                        time,
                        fontSize: Dimensions.titleSmall,
                        color: CustomColors.grayShade,
                      ),
                    ],
                  ),
                  Space.height.v5,
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: Dimensions.iconSizeDefault,
                        color: CustomColors.grayShade,
                      ),
                      Space.width.v5,
                      TextWidget(
                        date,
                        fontSize: Dimensions.titleSmall,
                        color: CustomColors.grayShade,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Space.width.v10,

            // Button Section
            if (!isCancelled && onPressed != null)
              SizedBox(
                height: Dimensions.buttonHeight * 0.7,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.defaultHorizontalSize,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.5,
                        color: isOngoing
                            ? CustomColors.primary
                            : CustomColors.primary,
                      ),
                      borderRadius: BorderRadius.circular(Dimensions.radius),
                    ),
                    backgroundColor: isOngoing
                        ? CustomColors.primary
                        : CustomColors.whiteColor,
                  ),
                  onPressed: onPressed,
                  child: TextWidget(
                    isOngoing ? 'Join' : 'Chat',
                    color: isOngoing
                        ? CustomColors.whiteColor
                        : CustomColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.titleSmall,
                  ),
                ),
              ),

            // Cancelled Badge
            if (isCancelled)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.defaultHorizontalSize * 0.8,
                  vertical: Dimensions.verticalSize * 0.4,
                ),
                decoration: BoxDecoration(
                  color: CustomColors.rejected.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  border: Border.all(
                    color: CustomColors.rejected,
                    width: 1.5,
                  ),
                ),
                child: TextWidget(
                  'Cancelled',
                  color: CustomColors.rejected,
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.titleSmall,
                ),
              ),
          ],
        ),
      ),
    );
  }
}