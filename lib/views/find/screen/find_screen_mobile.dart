part of 'find_screen.dart';

class FindScreenMobile extends GetView<FindController> {
  const FindScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Search", isBack: false),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: Dimensions.verticalSize),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radius),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                onChanged: (value) {},
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
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),

            TextWidget('Recent Search', fontWeight: FontWeight.w600),
            Space.height.v10,
            InkWell(
              onTap: () => Get.toNamed(Routes.doctorDetailsScreen),
              borderRadius: BorderRadius.circular(Dimensions.radius),
              child: Container(
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
                    Expanded(
                      child: Text(
                        'Dr. Elowyn Starcrest',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    TextWidget(
                      '2 hours ago',
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.titleSmall * 0.9,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
