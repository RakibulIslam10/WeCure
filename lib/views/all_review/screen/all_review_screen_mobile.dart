part of 'all_review_screen.dart';

class AllReviewScreenMobile extends GetView<AllReviewController> {
  const AllReviewScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Review and Rating"),
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? LoadingWidget()
              : controller.reviewList.isEmpty
              ? Center(
                  child: TextWidget(
                    'No reviews yet',
                    color: CustomColors.secondaryDarkText,
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.defaultHorizontalSize,
                    vertical: Dimensions.verticalSize,
                  ),
                  itemCount: controller.reviewList.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final review = controller.reviewList[index];
                    return Container(
                      margin: EdgeInsets.only(
                        bottom: Dimensions.heightSize * 1.2,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius),
                        border: Border.all(
                          color: CustomColors.grayShade.withOpacity(0.15),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.defaultHorizontalSize,
                        vertical: Dimensions.verticalSize * 0.8,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: crossStart,
                        children: [
                          Row(
                            children: [
                              ProfileAvatarWidget(
                                size: 36,
                                imageUrl: review.userId.profileImage,
                              ),
                              Space.width.v10,
                              Expanded(
                                child: TextWidget(
                                  review.userId.name,
                                  fontWeight: FontWeight.w600,
                                  fontSize: Dimensions.titleSmall,
                                ),
                              ),
                              TextWidget(
                                controller.timeAgo(review.createdAt),
                                fontSize: Dimensions.labelSmall,
                                color: CustomColors.secondaryDarkText,
                              ),
                            ],
                          ),
                          Space.height.v10,
                          Row(
                            children: List.generate(
                              5,
                              (i) => Icon(
                                i < review.rating
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 16.sp,
                                color: const Color(0xFFFF9500),
                              ),
                            ),
                          ),
                          Space.height.v10,
                          TextWidget(
                            review.reviewText,
                            fontWeight: FontWeight.w400,
                            fontSize: Dimensions.titleSmall,
                            color: CustomColors.secondaryDarkText,
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
