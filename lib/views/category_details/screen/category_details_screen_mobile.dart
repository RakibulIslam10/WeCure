part of 'category_details_screen.dart';

class CategoryDetailsScreenMobile extends GetView<CategoryDetailsController> {
  const CategoryDetailsScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Dentist"),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: Dimensions.defaultHorizontalSize,
            vertical: Dimensions.verticalSize * 0.5,
          ),
          itemCount: 10,
          addRepaintBoundaries: true,
          cacheExtent: 500,
          shrinkWrap: true,
          primary: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => Get.toNamed(Routes.doctorDetailsScreen),
            child: Container(
              margin: EdgeInsets.only(bottom: Dimensions.heightSize * 1.2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius),
                border: Border.all(
                  color: CustomColors.grayShade.withOpacity(0.15),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DoctorDetailsCard(
                    imageUrl:
                        'https://raw.githubusercontent.com/ai-py-auto/souce/refs/heads/main/Rectangle%202.png',
                    name: 'Dr. Elowyn Starcrest',
                    specialty: 'Dentist',
                    clinicName: 'Central Dental Care',
                    rating: 4.7,
                    yearsOfExperience: 12,
                    startingPrice: 10,
                    isPriceShow: false,
                    onTap: null,
                    borderHide: true,
                  ),
                  // Container(
                  //   height: 140.h,
                  //   color: Color(0xffF8F8F8),
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: Dimensions.defaultHorizontalSize,
                  //       vertical: Dimensions.verticalSize * 0.25,
                  //     ),
                  //     child: Column(
                  //       mainAxisSize: MainAxisSize.min,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             TextWidget(
                  //               'Choose Date',
                  //               fontWeight: FontWeight.w600,
                  //             ),
                  //             TextWidget(
                  //               'View all',
                  //               onTap: () {
                  //                 Get.dialog(
                  //                   CategoryDialog(),
                  //                   barrierDismissible: true,
                  //                 );
                  //               },
                  //               color: CustomColors.blackColor.withOpacity(0.7),
                  //               fontWeight: FontWeight.w600,
                  //             ),
                  //           ],
                  //         ),
                  //         Space.height.v10,
                  //         SingleChildScrollView(
                  //           scrollDirection: Axis.horizontal,
                  //           physics: BouncingScrollPhysics(),
                  //           child: Row(
                  //             children: List.generate(
                  //               5,
                  //               (index) => Container(
                  //                 margin: EdgeInsets.only(right: 8),
                  //                 // spacing between items
                  //                 padding: EdgeInsets.symmetric(
                  //                   horizontal:
                  //                       Dimensions.defaultHorizontalSize * 0.5,
                  //                   vertical: Dimensions.verticalSize * 0.4,
                  //                 ),
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(
                  //                     Dimensions.radius,
                  //                   ),
                  //                   color: CustomColors.primary,
                  //                 ),
                  //                 child: Column(
                  //                   crossAxisAlignment: crossStart,
                  //                   mainAxisSize: MainAxisSize.min,
                  //                   children: [
                  //                     TextWidget(
                  //                       "Sun \n12 Nov",
                  //                       color: CustomColors.whiteColor,
                  //                       fontSize: Dimensions.titleSmall,
                  //                     ),
                  //                     Space.height.v5,
                  //                     TextWidget(
                  //                       "10 Slots",
                  //                       color: CustomColors.whiteColor,
                  //                       fontSize: Dimensions.titleSmall,
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
