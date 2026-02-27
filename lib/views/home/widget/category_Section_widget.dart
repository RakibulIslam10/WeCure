part of '../screen/home_screen.dart';

class CategorySectionWidget extends GetView<HomeController> {
  const CategorySectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.defaultHorizontalSize),
      height: 120.h,
      child: Obx(
        () => ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: min(controller.specialitiesList.length, 10),
          addRepaintBoundaries: true,
          cacheExtent: 500,
          shrinkWrap: true,
          primary: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            if (index == controller.specialitiesList.length) {
              return PaginationLoaderWidget(
                index: index,
                list: controller.specialitiesList,
                currentPage: controller.specialitiesCurrentPage,
                fetchFunction: controller.fetchSpecialities,
              );
            }

            return GestureDetector(
              onTap: () => Get.toNamed(
                Routes.categoryDetailsScreen,
                arguments: {
                  'id' :  controller.specialitiesList[index].id,
                  'name' :  controller.specialitiesList[index].name,
                }
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.widthSize * 1.5,
                  vertical: Dimensions.verticalSize * 0.4,
                ),
                margin: EdgeInsets.only(right: Dimensions.widthSize),
                decoration: BoxDecoration(
                  color: Color(0xffF8F8F8),
                  border: Border.all(
                    color: CustomColors.disableColor.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.radius * 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          controller.specialitiesList[index].thumbnail
                                  ?.toString()
                                  .isNotEmpty ==
                              true
                          ? controller.specialitiesList[index].thumbnail
                                .toString()
                          : "https://www.iconpacks.net/icons/2/free-medicine-icon-3193-thumb.png",
                      height: 35.h,
                      placeholder: (_, __) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 35.h,
                          width: 35.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius * 0.5,
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (_, __, ___) => Icon(
                        Icons.image,
                        color: Colors.grey.shade400,
                        size: Dimensions.iconSizeLarge * 2.5,
                      ),
                    ),
                    Space.height.v10,
                    TextWidget(
                      controller.specialitiesList[index].name,
                      color: CustomColors.primary,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
