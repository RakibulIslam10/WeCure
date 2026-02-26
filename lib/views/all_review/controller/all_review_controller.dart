import 'package:glady/core/api/services/api_request.dart';
import 'package:glady/views/all_review/model/all_review_model.dart';
import '../../../core/utils/basic_import.dart';

class AllReviewController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    getAllReviews();
  }

  RxBool isLoading = false.obs;


  AllReviewModel? allReviewModel;
  RxList<Reviews> reviewList = <Reviews>[].obs;

  Future<AllReviewModel> getAllReviews() async {
    return ApiRequest().get(
      fromJson: AllReviewModel.fromJson,
      endPoint: '/reviews',
      isLoading: isLoading,
      onSuccess: (result) {
        allReviewModel = result;
        reviewList.assignAll(result.data);
      },
    );
  }

  String timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays >= 1) return '${diff.inDays} Day${diff.inDays > 1 ? 's' : ''} Ago';
    if (diff.inHours >= 1) return '${diff.inHours} Hour${diff.inHours > 1 ? 's' : ''} Ago';
    return '${diff.inMinutes} Min Ago';
  }
}