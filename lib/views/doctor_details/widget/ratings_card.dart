import '../../../core/utils/basic_import.dart';
import '../controller/doctor_details_controller.dart';

class RatingsCard extends GetView<DoctorDetailsController> {
  const RatingsCard({super.key});

  @override
  Widget build(BuildContext context) {

    final rating = controller.doctorDetailsInfoModel?.data.rating;
    if (rating == null) return const SizedBox.shrink();
    final totalCount = rating.total == 0 ? 1 : rating.total;

    return Column(
      children: List.generate(5, (index) {
        final star = 5 - index;
        final count = rating.breakdown[star.toString()] ?? 0;
        final percentage = count / totalCount;

        return Padding(
          padding: EdgeInsets.only(bottom: Dimensions.heightSize * 0.8),
          child: Row(
            children: [
              SizedBox(
                width: Dimensions.widthSize,
                child: Text(
                  '$star',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ),
              Space.width.v10,
              Icon(Icons.star, size: 16.sp, color: Color(0xFFFF9500)),
              Space.width.v10,
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  child: Stack(
                    children: [
                      Container(
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5E5E5),
                          borderRadius: BorderRadius.circular(Dimensions.radius),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: percentage,
                        child: Container(
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF9500),
                            borderRadius: BorderRadius.circular(Dimensions.radius),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Space.width.v10,
              SizedBox(
                width: 24,
                child: Text(
                  '$count',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildRatingRow(int stars, int count, double percentage) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.heightSize * 0.8),
      child: Row(
        children: [
          SizedBox(
            width: Dimensions.widthSize,
            child: Text(
              '$stars',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),

          Space.width.v10,
          Icon(Icons.star, size: 16.sp, color: Color(0xFFFF9500)),
          Space.width.v10,

          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.radius),
              child: Stack(
                children: [
                  Container(
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E5E5),
                      borderRadius: BorderRadius.circular(Dimensions.radius),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: percentage,
                    child: Container(
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF9500),
                        borderRadius: BorderRadius.circular(Dimensions.radius),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Space.width.v10,
          SizedBox(
            width: 24,
            child: Text(
              '$count',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
