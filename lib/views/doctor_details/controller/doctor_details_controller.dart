import 'package:glady/core/api/services/api_request.dart';
import 'package:glady/views/doctor_details/model/doctor_details_model.dart';
import '../../../core/utils/basic_import.dart';
import '../model/rating_model.dart';

class DoctorDetailsController extends GetxController {
  String? doctorId = '';

  @override
  void onInit() {
    super.onInit();
    doctorId = Get.arguments as String;
    getDoctorDetailsInfo(doctorId ?? '');
  }

  // Rating breakdown
  final ratings = <RatingData>[
    RatingData(stars: 5, count: 80),
    RatingData(stars: 4, count: 20),
    RatingData(stars: 3, count: 12),
    RatingData(stars: 2, count: 6),
    RatingData(stars: 1, count: 2),
  ].obs;

  int get totalRatings => ratings.fold(0, (sum, r) => sum + r.count);
  double getPercentage(int count) =>
      totalRatings > 0 ? count / totalRatings : 0.0;

  // Booking Dialog
  RxString selectedDate = ''.obs;
  RxString selectedTime = ''.obs;
  RxBool showTimeSlots = false.obs;
  RxInt selectedDateIndex = (-1).obs;
  RxInt selectedTimeIndex = (-1).obs;

  final List<String> datesDayList = [
    'Sun 1 Jan', 'Mon 5 Feb', 'Tue 8 Mar', 'Wed 1 Apr',
    'Thu 4 May', 'Fri 27 Jun', 'Sat 14 Jul', 'Sun 8 Aug',
    'Mon 23 Sep', 'Tue 20 Oct', 'Wed 5 Nov', 'Thu 16 Dec',
  ];

  final List<String> timeList = [
    '09:00 AM', '10:00 AM', '11:00 AM', '12:00 PM',
    '02:00 PM', '03:00 PM', '04:00 PM', '05:00 PM', '06:00 PM',
  ];

  // API
  RxBool isLoading = false.obs;
  DoctorDetailsInfoModel? doctorDetailsInfoModel;

  Future<DoctorDetailsInfoModel> getDoctorDetailsInfo(String doctorId) async {
    return ApiRequest().get(
      fromJson: DoctorDetailsInfoModel.fromJson,
      endPoint: '/doctors/$doctorId/public',
      isLoading: isLoading,
      onSuccess: (result) {
        doctorDetailsInfoModel = result;
      },
    );
  }
}