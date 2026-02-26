import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/api/services/api_request.dart';
import '../../../core/utils/basic_import.dart';
import '../../home/model/popular_specialities_model.dart';

class AllCategoryController extends GetxController {
  final int limit = 10;

  // ── Specialities ──
  RxList<Specialities> specialitiesList = <Specialities>[].obs;
  RxBool isLoadingSpecialities = false.obs;
  RxInt specialitiesCurrentPage = 1.obs;
  RxInt specialitiesTotalPages = 1.obs;
  RxBool specialitiesHasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSpecialities();
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

        specialitiesHasMore.value =
            specialitiesCurrentPage.value < specialitiesTotalPages.value;
      },
    );
  }
}
