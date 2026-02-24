part of '../screen/home_screen.dart';

class HomeDoctorCardWidget extends GetView<HomeController> {
  const HomeDoctorCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.defaultHorizontalSize),
      height: 240.h,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        addRepaintBoundaries: true,
        cacheExtent: 500,
        shrinkWrap: true,
        primary: true,
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) => DoctorCardWidget(
          imageUrl: controller.allDoctorsList[index].profileImage ?? '',
          rating:
              controller.allDoctorsList[index].averageRating.toStringAsFixed(
                1,
              ) ??
              '0.0',
          name: controller.allDoctorsList[index].name,
          profession: controller.allDoctorsList[index].specialty,
          onTap: () {
            Get.toNamed(Routes.doctorDetailsScreen);
          },
          hospital:
              controller.allDoctorsList[index].currentOrganization ??
              'Unknown Hospital',
        ),
      ),
    );
  }
}
