part of 'all_doctors_screen.dart';

class AllDoctorsScreenMobile extends GetView<AllDoctorsController> {
  const AllDoctorsScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "All Doctors"),
      body: Obx(
        () => controller.isLoadingDoctors.value
            ? LoadingWidget()
            : GridView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.defaultHorizontalSize,
                  vertical: Dimensions.verticalSize * 0.25,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  mainAxisSpacing: Dimensions.heightSize,
                ),
                itemCount: controller.allDoctorsList.length + (controller.doctorsHasMore.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == controller.allDoctorsList.length) {
                    if (index == controller.allDoctorsList.length) {
                      return PaginationLoaderWidget(
                        index: index,
                        list: controller.allDoctorsList,
                        currentPage: controller.doctorsCurrentPage,
                        fetchFunction: controller.fetchAllPopularDoctor,
                      );
                    }
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSize * 0.5,
                        ),
                        child: CircularProgressIndicator(
                          color: CustomColors.primary,
                        ),
                      ),
                    );
                  }

                  return DoctorCardWidget(
                    imageUrl:
                        controller.allDoctorsList[index].profileImage ?? '',
                    rating:
                        controller.allDoctorsList[index].averageRating
                            .toStringAsFixed(1) ??
                        '0.0',
                    name: controller.allDoctorsList[index].name,
                    profession: controller.allDoctorsList[index].specialty,
                    onTap: () {
                      Get.toNamed(
                        Routes.doctorDetailsScreen,
                        arguments: controller.allDoctorsList[index].id,
                      );
                    },
                    hospital:
                        controller.allDoctorsList[index].currentOrganization ??
                        'Unknown Hospital',
                  );
                },
              ),
      ),
    );
  }
}
