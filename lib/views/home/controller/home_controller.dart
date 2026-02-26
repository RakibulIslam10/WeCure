import 'package:glady/core/api/services/api_request.dart';
import 'package:glady/views/home/model/popular_doctor_model.dart';
import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/utils/basic_import.dart';
import '../model/popular_specialities_model.dart';
import '../model/wellness_tips_model.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;

  // ── Wellness Tips ──
  RxList<AllTips> wellnessTipsList = <AllTips>[].obs;
  RxBool isLoadingWellnessTips = false.obs;
  RxInt tipsCurrentPage = 1.obs;
  RxInt tipsTotalPages = 1.obs;
  RxBool tipsHasMore = true.obs;

  // ── Doctors ──
  RxList<AllDoctors> allDoctorsList = <AllDoctors>[].obs;
  RxBool isLoadingDoctors = false.obs;
  RxInt doctorsCurrentPage = 1.obs;
  RxInt doctorsTotalPages = 1.obs;
  RxBool doctorsHasMore = true.obs;

  // ── Specialities ──
  RxList<Specialities> specialitiesList = <Specialities>[].obs;
  RxBool isLoadingSpecialities = false.obs;
  RxInt specialitiesCurrentPage = 1.obs;
  RxInt specialitiesTotalPages = 1.obs;
  RxBool specialitiesHasMore = true.obs;

  final int limit = 10;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    try {
      isLoading.value = true;
      await Future.wait([
        fetchWellnessTips(),
        fetchPopularDoctor(),
        fetchSpecialities(),
      ]);
    } finally {
      isLoading.value = false;
    }
  }

  Future<WellnessTipModel> fetchWellnessTips() async {
    return ApiRequest().get(
      fromJson: WellnessTipModel.fromJson,
      endPoint: ApiEndPoints.wellnessTips,
      isLoading: isLoadingWellnessTips,
      isPagination: true,
      page: tipsCurrentPage.value,
      limit: limit,
      onSuccess: (result) {
        if (tipsCurrentPage.value == 1) wellnessTipsList.clear();
        wellnessTipsList.addAll(result.allTips);
        tipsTotalPages.value = (result.meta.total / limit).ceil();
        tipsHasMore.value = tipsCurrentPage.value < tipsTotalPages.value;
      },
    );
  }

  Future<PopularDoctorModel> fetchPopularDoctor() async {
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
      },
    );
  }

  Future<PopularSpecialitesModel> fetchSpecialities() async {
    return ApiRequest().get(
      fromJson: PopularSpecialitesModel.fromJson,
      endPoint: ApiEndPoints.getSpecialties,
      isLoading: isLoadingSpecialities,
      isPagination: true,
      page: specialitiesCurrentPage.value,
      limit: limit,
      onSuccess: (result) {
        if (specialitiesCurrentPage.value == 1) specialitiesList.clear();
        specialitiesList.addAll(result.data);
        specialitiesTotalPages.value = (result.meta.total / limit).ceil();
        specialitiesHasMore.value = specialitiesCurrentPage.value < specialitiesTotalPages.value;
      },
    );
  }
}