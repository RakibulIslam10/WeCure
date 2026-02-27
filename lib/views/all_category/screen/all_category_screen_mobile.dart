part of 'all_category_screen.dart';

class AllCategoryScreenMobile extends GetView<AllCategoryController> {
  const AllCategoryScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "All Medical Specialties"),
      body: SafeArea(
        child: Obx(
          () =>
              controller.isLoadingSpecialities.value &&
                  controller.specialitiesList.isEmpty
              ? LoadingWidget()
              : GridView.builder(
                  itemCount:
                      controller.specialitiesList.length +
                      (controller.specialitiesHasMore.value ? 1 : 0),
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: Dimensions.defaultHorizontalSize,
                    vertical: Dimensions.verticalSize,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 5 / 2,
                    crossAxisSpacing: Dimensions.widthSize,
                  ),
                  itemBuilder: (context, index) {
                    if (index == controller.specialitiesList.length) {
                      return PaginationLoaderWidget(
                        index: index,
                        list: controller.specialitiesList,
                        currentPage: controller.specialitiesCurrentPage,
                        fetchFunction: controller.fetchSpecialities,
                      );
                    }
                    final item = controller.specialitiesList[index];
                    return GestureDetector(
                      onTap: () => Get.toNamed(
                        Routes.categoryDetailsScreen,
                          arguments: {
                            'id' :  controller.specialitiesList[index].id,
                            'name' :  controller.specialitiesList[index].name,
                          }
                      ),
                      child: Container(
                        alignment: AlignmentGeometry.center,
                        margin: EdgeInsets.only(bottom: Dimensions.heightSize),
                        decoration: BoxDecoration(
                          color: Color(0xffF8F8F8),
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius * 1.5,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.defaultHorizontalSize,
                            vertical: Dimensions.verticalSize * 0.7,
                          ),
                          child: TextWidget(
                            item.name,
                            maxLines: 2,
                            color: CustomColors.primary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
