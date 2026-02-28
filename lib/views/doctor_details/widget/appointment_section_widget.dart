part of '../screen/doctor_details_screen.dart';

class AppointmentSectionWidget extends StatelessWidget {
  final String days;
  final String time;
  final String price;
  final String slot;
  final String duration;

  const AppointmentSectionWidget({
    super.key,
    required this.days,
    required this.time,
    required this.price,
    required this.slot,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainSpaceBet,
      crossAxisAlignment: crossStart,
      children: [
        Row(
          crossAxisAlignment: crossStart,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: const Icon(Icons.circle_outlined, color: Color(0xff006C93)),
            ),
            Space.width.v10,
            Column(
              crossAxisAlignment: crossStart,
              children: [
                TextWidget(days, fontSize: Dimensions.titleSmall),
                TextWidget(
                  time,
                  fontSize: Dimensions.titleSmall,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: crossEnd,
          children: [
            Row(
              crossAxisAlignment: crossCenter,
              children: [
                TextWidget(slot, fontSize: Dimensions.titleSmall),
                Space.width.v5,
                TextWidget(
                  duration,
                  fontSize: Dimensions.titleSmall,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            TextWidget(
              price,
              fontSize: Dimensions.titleSmall,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ],
    );
  }
}


