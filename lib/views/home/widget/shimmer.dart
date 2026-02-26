import 'package:shimmer/shimmer.dart';
import '../../../core/utils/basic_import.dart';

class UserHomeShimmerWidget extends StatelessWidget {
  const UserHomeShimmerWidget({super.key});

  Widget _box({double? width, double? height, double? radius, BorderRadius? borderRadius}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 8.r),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalSize),
        child: Column(
          crossAxisAlignment: crossStart,
          children: [
            Space.height.v20,

            // Search Bar
            _box(
              width: double.infinity,
              height: Dimensions.inputBoxHeight,
              radius: Dimensions.radius * 3,
            ),

            Space.height.v30,

            // Banner / Hero Slider
            _box(
              width: double.infinity,
              height: 160.h,
              radius: Dimensions.radius * 1.5,
            ),

            Space.height.v10,

            // Dots indicator
            Row(
              mainAxisAlignment: mainCenter,
              children: List.generate(3, (i) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: _box(
                  width: i == 0 ? 20.w : 8.w,
                  height: 6.h,
                  radius: 4.r,
                ),
              )),
            ),

            Space.height.v25,

            // Daily Wellness Tips header
            Row(
              mainAxisAlignment: mainSpaceBet,
              children: [
                _box(width: 140.w, height: 16.h, radius: 4.r),
                _box(width: 55.w, height: 14.h, radius: 4.r),
              ],
            ),

            Space.height.v15,

            // Wellness Tips Card (horizontal scroll preview)
            SizedBox(
              height: 110.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                separatorBuilder: (_, __) => Space.width.v15,
                itemBuilder: (_, __) => _box(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: 110.h,
                  radius: Dimensions.radius * 1.5,
                ),
              ),
            ),

            Space.height.v25,

            // Popular Specialties header
            Row(
              mainAxisAlignment: mainSpaceBet,
              children: [
                _box(width: 130.w, height: 16.h, radius: 4.r),
                _box(width: 55.w, height: 14.h, radius: 4.r),
              ],
            ),

            Space.height.v15,

            // Specialties Icons Row
            SizedBox(
              height: 90.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                separatorBuilder: (_, __) => Space.width.v15,
                itemBuilder: (_, __) => Column(
                  children: [
                    _box(width: 64.w, height: 64.h, radius: Dimensions.radius),
                    Space.height.v5,
                    _box(width: 50.w, height: 10.h, radius: 4.r),
                  ],
                ),
              ),
            ),

            Space.height.v25,

            // Popular Doctor header
            Row(
              mainAxisAlignment: mainSpaceBet,
              children: [
                _box(width: 120.w, height: 16.h, radius: 4.r),
                _box(width: 55.w, height: 14.h, radius: 4.r),
              ],
            ),

            Space.height.v15,

            // Doctor Cards Row
            SizedBox(
              height: 200.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                separatorBuilder: (_, __) => Space.width.v15,
                itemBuilder: (_, __) => SizedBox(
                  width: 140.w,
                  child: Column(
                    crossAxisAlignment: crossStart,
                    children: [
                      _box(
                        width: 140.w,
                        height: 130.h,
                        radius: Dimensions.radius * 1.2,
                      ),
                      Space.height.v10,
                      _box(width: 110.w, height: 13.h, radius: 4.r),
                      Space.height.v5,
                      _box(width: 80.w, height: 11.h, radius: 4.r),
                      Space.height.v5,
                      _box(width: 90.w, height: 10.h, radius: 4.r),
                    ],
                  ),
                ),
              ),
            ),

            Space.height.v20,
          ],
        ),
      ),
    );
  }
}