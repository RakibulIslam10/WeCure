import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/api/services/api_request.dart';
import '../../../core/utils/basic_import.dart';
import '../../home/model/wellness_tips_model.dart';

class TipsController extends GetxController {
  // ── Wellness Tips ──
  RxList<AllTips> wellnessTipsList = <AllTips>[].obs;
  RxList<AllTips> wellnessLickedTipsList = <AllTips>[].obs;
  RxBool isLoadingWellnessTips = false.obs;
  RxInt tipsCurrentPage = 1.obs;
  RxInt tipsTotalPages = 1.obs;
  RxBool tipsHasMore = true.obs;

  final int limit = 10;

  @override
  void onInit() {
    super.onInit();
    fetchWellnessTips();



  }

  Future<WellnessTipModel> fetchWellnessTips() async {
    return ApiRequest().get(
      fromJson: WellnessTipModel.fromJson,
      endPoint: ApiEndPoints.wellnessTips,
      isLoading: isLoadingWellnessTips,
      isPagination: true,
      showResponse: true,
      page: tipsCurrentPage.value,
      limit: limit,
      onSuccess: (result) {
        if (tipsCurrentPage.value == 1) wellnessTipsList.clear();
        wellnessTipsList.addAll(result.allTips);
        tipsTotalPages.value = (result.meta.total / limit).ceil();
        tipsHasMore.value = tipsCurrentPage.value < tipsTotalPages.value;


        wellnessLickedTipsList.clear();
        wellnessLickedTipsList.addAll(result.allTips.where((tip) => tip.isFavourite == true));


      },
    );
  }
}
