import 'package:glady/core/api/services/api_request.dart';
import 'package:glady/views/home/model/popular_doctor_model.dart';
import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/utils/basic_import.dart';
import '../model/popular_specialities_model.dart';
import '../model/wellness_tips_model.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;

  RxList<AllTips> wellnessTipsList = <AllTips>[].obs;
  RxBool isLoadingTips = false.obs;

  // Pagination
  RxInt currentPage = 1.obs;
  RxInt totalPages = 1.obs;
  RxBool hasMore = true.obs;
  final int limit = 10;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  RxBool isLoading = false.obs;

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

  RxBool isLoadingWellnessTips = false.obs;

  Future<WellnessTipModel> fetchWellnessTips() async {
    return ApiRequest().get(
      fromJson: WellnessTipModel.fromJson,
      endPoint: ApiEndPoints.wellnessTips,
      isLoading: isLoadingWellnessTips,
      isPagination: true,
      page: currentPage.value,
      limit: limit,
      onSuccess: (result) {
        if (currentPage.value == 1) wellnessTipsList.clear();
        wellnessTipsList.addAll(result.allTips);
        totalPages.value = (result.meta.total / limit).ceil();
        hasMore.value = currentPage.value < totalPages.value;
      },
    );
  }

  RxList<AllDoctors> allDoctorsList = <AllDoctors>[].obs;

  Future<PopularDoctorModel> fetchPopularDoctor() async {
    return ApiRequest().get(
      fromJson: PopularDoctorModel.fromJson,
      endPoint: ApiEndPoints.wellnessTips,
      isLoading: isLoading,
      isPagination: true,
      page: currentPage.value,
      limit: limit,
      onSuccess: (result) {
        if (currentPage.value == 1) allDoctorsList.clear();
        allDoctorsList.addAll(result.data);
        // totalPages.value = (result.meta.total / limit).ceil();
        hasMore.value = currentPage.value < totalPages.value;
      },
    );
  }

  RxList<Specialities> specialitiesList = <Specialities>[].obs;

  RxBool isLoadingSpecialities = false.obs;

  Future<PopularSpecialitesModel> fetchSpecialities() async {
    return ApiRequest().get(
      fromJson: PopularSpecialitesModel.fromJson,
      endPoint: ApiEndPoints.getSpecialties,
      isLoading: isLoadingSpecialities,
      isPagination: true,
      page: currentPage.value,
      limit: limit,
      onSuccess: (result) {
        if (currentPage.value == 1) specialitiesList.clear();
        specialitiesList.addAll(result.data);
        totalPages.value = (result.meta.total / limit).ceil();
        hasMore.value = currentPage.value < totalPages.value;
      },
    );
  }
}
