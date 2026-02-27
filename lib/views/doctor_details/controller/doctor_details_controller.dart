import 'package:glady/core/api/end_point/api_end_points.dart';
import 'package:glady/core/api/services/api_request.dart';
import 'package:glady/views/doctor_details/model/all_date_model.dart';
import 'package:glady/views/doctor_details/model/doctor_details_model.dart';
import 'package:glady/views/doctor_details/model/time_model.dart';
import '../../../core/utils/basic_import.dart';
import '../model/rating_model.dart';


class DoctorDetailsController extends GetxController {
  String? doctorId = '';

  @override
  void onInit() {
    super.onInit();
    doctorId = Get.arguments as String;
    getDoctorDetailsInfo(doctorId ?? '');
    fetchAllDate();
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

  RxList<AllDates> datesDayList = <AllDates>[].obs;
  RxList<AllTimes> timeList = <AllTimes>[].obs;

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

  RxBool isLoadingDate = false.obs;
  AllDateModel? allDateModel;

  Future<void> fetchAllDate() async {
    try {
      await ApiRequest().get(
        fromJson: AllDateModel.fromJson,
        endPoint: ApiEndPoints.availableDates,
        queryParams: {'doctorId': doctorId},
        isLoading: isLoadingDate,
        onSuccess: (result) {
          allDateModel = result;
          datesDayList.clear();
          datesDayList.assignAll(result.data);
        },
      );
    } catch (_) {}
  }

  RxBool isLoadingTime = false.obs;
  AllTimeModel? allTimeModel;

  Future<void> fetchAllTimes(String date) async {
    try {
      timeList.clear();
      selectedTimeIndex.value = -1;
      selectedTime.value = '';
      await ApiRequest().get(
        fromJson: AllTimeModel.fromJson,
        endPoint: ApiEndPoints.availableSlots,
        queryParams: {'doctorId': doctorId, 'date': date},
        isLoading: isLoadingTime,
        onSuccess: (result) {
          allTimeModel = result;
          timeList.assignAll(result.data);
        },
      );
    } catch (_) {}
  }
}