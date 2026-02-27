import 'package:glady/core/api/end_point/api_end_points.dart';

import '../../../core/api/services/api_request.dart';
import '../../../core/utils/basic_import.dart';
import '../model/search_doctor_model.dart';

class FindController extends GetxController {
  RxList<SearchDoctorModel> searchResults = <SearchDoctorModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasSearched = false.obs;
  RxList<String> recentSearches = <String>[].obs;

  final TextEditingController searchController = TextEditingController();

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> searchDoctors(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      hasSearched.value = false;
      return;
    }

    hasSearched.value = true;

    await ApiRequest().get(
      fromJson: (json) => json,
      endPoint: '${ApiEndPoints.searchDoctors}$query',
      isLoading: isLoading,
      onSuccess: (result) {
        final doctors = result['data']['doctors']['data'] as List;
        searchResults.value = doctors
            .map((e) => SearchDoctorModel.fromJson(e))
            .toList();

        if (query.trim().isNotEmpty && !recentSearches.contains(query.trim())) {
          recentSearches.insert(0, query.trim());
          if (recentSearches.length > 5) recentSearches.removeLast();
        }
      },
    );
  }

  void removeRecentSearch(String query) {
    recentSearches.remove(query);
  }
}
