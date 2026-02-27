import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/api/services/api_request.dart';
import '../../../core/utils/basic_import.dart';
import '../../home/model/popular_doctor_model.dart';

class AllDoctorsController extends GetxController {
  final int limit = 10;

  // ── Doctors ──
  RxList<AllDoctors> allDoctorsList = <AllDoctors>[].obs;
  RxBool isLoadingDoctors = false.obs;
  RxInt doctorsCurrentPage = 1.obs;
  RxInt doctorsTotalPages = 1.obs;
  RxBool doctorsHasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllPopularDoctor();
  }

  Future<PopularDoctorModel> fetchAllPopularDoctor() async {
    return ApiRequest().get(
      fromJson: PopularDoctorModel.fromJson,
      endPoint: ApiEndPoints.getPopularDoctors,
      isLoading: isLoadingDoctors,
      isPagination: true,
      page: doctorsCurrentPage.value,
      limit: limit,
      onSuccess: (result) {
        if (doctorsCurrentPage.value == 1) allDoctorsList.clear();
        allDoctorsList.addAll(result.data);
        doctorsTotalPages.value = (result.meta.total / limit).ceil();
        doctorsHasMore.value =
            doctorsCurrentPage.value < doctorsTotalPages.value;
      },
    );
  }
}
