part of 'tips_screen.dart';

class TipsScreenMobile extends GetView<TipsController> {
  const TipsScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Daily Health Tips",
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.likedTipsScreen),
            icon: Icon(Icons.favorite_border, color: CustomColors.rejected),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () =>
              controller.isLoadingWellnessTips.value &&
                  controller.wellnessTipsList.isEmpty
              ? LoadingWidget()
              : ListView.builder(
                  itemCount:
                      controller.wellnessTipsList.length +
                      (controller.tipsHasMore.value ? 1 : 0),
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: Dimensions.defaultHorizontalSize,
                    vertical: Dimensions.verticalSize,
                  ),
                  itemBuilder: (context, index) {
                    if (index == controller.wellnessTipsList.length) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (!controller.isLoadingWellnessTips.value &&
                            controller.tipsHasMore.value) {
                          controller.tipsCurrentPage.value++;
                          controller.fetchWellnessTips();
                        }
                      });
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
                    final tip = controller.wellnessTipsList[index];
                    return Container(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              tip.content,
                              fontWeight: FontWeight.w500,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: CustomColors.disableColor,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(
                                Dimensions.paddingSize * 0.4,
                              ),
                              child: tip.isFavourite == false
                                  ? Icon(
                                      Icons.favorite_border,
                                      color: CustomColors.whiteColor,
                                    )
                                  : Icon(
                                      Icons.favorite,
                                      color: Colors.redAccent,
                                    ),
                            ),
                          ],
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
