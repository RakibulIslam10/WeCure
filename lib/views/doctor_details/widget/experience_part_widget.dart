part of '../screen/doctor_details_screen.dart';


class ExperiencePartWidget extends GetView<DoctorDetailsController> {
  const ExperiencePartWidget({super.key});

  String _formatDate(DateTime date) => DateFormat('dd MMM yyyy').format(date);

  String _duration(DateTime start, DateTime end, bool isCurrent) {
    final to = isCurrent ? DateTime.now() : end;
    final months = (to.year - start.year) * 12 + to.month - start.month;
    final years = months ~/ 12;
    final rem = months % 12;
    if (years > 0 && rem > 0) return '$years year${years > 1 ? 's' : ''} $rem month${rem > 1 ? 's' : ''}';
    if (years > 0) return '$years year${years > 1 ? 's' : ''}';
    return '$rem month${rem > 1 ? 's' : ''}';
  }

  @override
  Widget build(BuildContext context) {
    final experiences = controller.doctorDetailsInfoModel?.data.experiences ?? [];
    if (experiences.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: crossStart,
      children: [
        TextWidget("Experience"),
        Space.height.v5,
        ...experiences.map((exp) => Padding(
          padding: EdgeInsets.only(bottom: Dimensions.heightSize * 2),
          child: Column(
            mainAxisSize: mainMin,
            crossAxisAlignment: crossStart,
            children: [
              TextWidget(
                exp.organizationName,
                fontWeight: FontWeight.w500,
                fontSize: Dimensions.titleSmall,
              ),
              Space.height.v5,
              TextWidget(
                exp.designation,
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.titleSmall,
              ),
              TextWidget(
                '${_formatDate(exp.startDate)} - ${exp.isCurrent ? 'Present' : _formatDate(exp.endDate)}',
                fontWeight: FontWeight.w400,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
                fontSize: Dimensions.titleSmall,
              ),
              TextWidget(
                _duration(exp.startDate, exp.endDate, exp.isCurrent),
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.titleSmall,
              ),
            ],
          ),
        )),
      ],
    );
  }
}