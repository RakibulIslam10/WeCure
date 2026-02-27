part of 'find_screen.dart';

class FindScreenMobile extends GetView<FindController> {
  const FindScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Search", isBack: false),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: crossStart,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.defaultHorizontalSize,
                vertical: Dimensions.verticalSize * 0.8,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: controller.searchController,
                  onChanged: (value) => controller.searchDoctors(value),
                  cursorColor: CustomColors.primary,
                  decoration: InputDecoration(
                    hintText: 'Find Specialties or Doctor',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: Dimensions.titleMedium * 0.9,
                    ),
                    suffixIcon: Icon(
                      CupertinoIcons.search,
                      color: CustomColors.primary,
                      size: Dimensions.iconSizeLarge,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) return LoadingWidget();

                if (!controller.hasSearched.value) {
                  return _buildRecentSearches();
                }

                if (controller.searchResults.isEmpty) {
                  return EmptyDataWidget(massage: 'No doctors found.');
                }

                return _buildSearchResults();
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearches() {
    return Obx(() {
      if (controller.recentSearches.isEmpty) {
        return EmptyDataWidget(massage: 'No recent searches.');
      }

      return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.defaultHorizontalSize,
        ),
        children: [
          TextWidget('Recent Search', fontWeight: FontWeight.w600),
          Space.height.v10,
          ...controller.recentSearches.map(
                (query) => InkWell(
              onTap: () {
                controller.searchController.text = query;
                controller.searchDoctors(query);
              },
              borderRadius: BorderRadius.circular(Dimensions.radius),
              child: Container(
                margin: EdgeInsets.only(bottom: Dimensions.heightSize * 0.8),
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.defaultHorizontalSize,
                  vertical: Dimensions.heightSize,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.clock,
                      size: Dimensions.iconSizeDefault,
                      color: CustomColors.grayShade,
                    ),
                    Space.width.v10,
                    Expanded(
                      child: TextWidget(
                        query,
                        fontWeight: FontWeight.w500,
                        fontSize: Dimensions.titleSmall,
                      ),
                    ),
                    InkWell(
                      onTap: () => controller.removeRecentSearch(query),
                      child: Icon(
                        Icons.close,
                        size: Dimensions.iconSizeDefault,
                        color: CustomColors.grayShade,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.defaultHorizontalSize,
        vertical: Dimensions.verticalSize * 0.5,
      ),
      itemCount: controller.searchResults.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final doctor = controller.searchResults[index];
        return Container(
          margin: EdgeInsets.only(bottom: Dimensions.heightSize * 1.2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius),
            border: Border.all(
              color: CustomColors.grayShade.withOpacity(0.15),
            ),
          ),
          child: DoctorDetailsCard(
            imageUrl: doctor.profileImage ?? '',
            name: doctor.name,
            specialty: doctor.specialty,
            clinicName: doctor.currentOrganization,
            rating: doctor.averageRating,
            yearsOfExperience: doctor.totalExperienceYears,
            startingPrice: doctor.minFee.toDouble(),
            isPriceShow: false,
            borderHide: true,
            onTap: () => Get.toNamed(
              Routes.doctorDetailsScreen,
              arguments: doctor.id,
            ),
          ),
        );
      },
    );
  }
}