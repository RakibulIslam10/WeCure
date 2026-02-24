part of '../screen/home_screen.dart';

class CategorySectionWidget extends GetView<HomeController> {
  const CategorySectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.defaultHorizontalSize),
      height: 120.h,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: controller.specialitiesList.length,
        addRepaintBoundaries: true,
        cacheExtent: 500,
        shrinkWrap: true,
        primary: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Get.toNamed(Routes.categoryDetailsScreen),
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
                  imageUrl: controller.specialitiesList[index].thumbnail ?? "https://www.iconpacks.net/icons/2/free-medicine-icon-3193-thumb.png",
                  height: 35.h,
                  // color: CustomColors.primary,
                  errorWidget: (_, __, ___) => Icon(
                    Icons.image,
                    color: Colors.grey.shade400,
                    size: Dimensions.iconSizeLarge * 2.5,
                  ),
                ),

                Space.height.v10,
                TextWidget(
                  "Medicine",
                  color: CustomColors.primary,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
