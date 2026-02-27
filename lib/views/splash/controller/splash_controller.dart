import '../../../core/utils/app_storage.dart';
import '../../../core/utils/basic_import.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Future.delayed(Duration(seconds: 3), () {
      if (!AppStorage.onboardSave) {
        Get.offAllNamed(Routes.onboardScreen);
      } else if (AppStorage.isLoggedIn) {
        Get.offAllNamed(Routes.navigationScreen);
      } else {
        Get.offAllNamed(Routes.loginScreen);
      }
    });
  }
}
