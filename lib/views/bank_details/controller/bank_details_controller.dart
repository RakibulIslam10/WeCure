import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/api/model/basic_success_model.dart';
import '../../../core/api/services/api_request.dart';
import '../../../core/utils/app_storage.dart';
import '../../../core/utils/basic_import.dart';
import '../model/bank_details_model.dart';

import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/api/model/basic_success_model.dart';
import '../../../core/api/services/api_request.dart';
import '../../../core/utils/app_storage.dart';
import '../../../core/utils/basic_import.dart';
import '../model/bank_details_model.dart';

class BankDetailsController extends GetxController {
  final bankNameController = TextEditingController();
  final isBankNameFocus = FocusNode();
  final accountNameController = TextEditingController();
  final numberController = TextEditingController();
  final passwordFocus = FocusNode();

  RxBool isLoading = false.obs;
  RxBool isGetDetails = false.obs;

  static final ApiRequest _api = ApiRequest();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<BasicSuccessModel> addDoctorBankAccount() async {
    return await _api.post(
      fromJson: BasicSuccessModel.fromJson,
      endPoint: ApiEndPoints.addDoctorBankAccount,
      isLoading: isLoading,
      showSuccessSnackBar: true,
      body: {
        "bankName": bankNameController.text,
        "accountName": accountNameController.text,
        "accountNumber": numberController.text,
      },
      onSuccess: (result) {
        Get.back();
      },
    );
  }

  Future<BasicSuccessModel> addUserBankAccount() async {
    return await _api.patch(
      fromJson: BasicSuccessModel.fromJson,
      endPoint: ApiEndPoints.addUserBankAccount,
      isLoading: isLoading,
      showSuccessSnackBar: true,
      body: {
        "bankName": bankNameController.text,
        "accountName": accountNameController.text,
        "accountNumber": numberController.text,
      },
      onSuccess: (result) {
        Get.back();
      },
    );
  }

  Future<BankDetailsModel> getUserBankAccount() async {
    return await _api.get(
      fromJson: BankDetailsModel.fromJson,
      endPoint: ApiEndPoints.addUserBankAccount,
      isLoading: isGetDetails,
      onSuccess: (result) {
        accountNameController.text = result.data?.accountName ?? '';
        numberController.text = result.data?.accountNumber ?? '';
        bankNameController.text = result.data?.bankName ?? '';
      },
    );
  }

  Future<BankDetailsModel> getBankDetails() async {
    return await _api.get(
      fromJson: BankDetailsModel.fromJson,
      endPoint: ApiEndPoints.addDoctorBankAccount,
      isLoading: isGetDetails,
      onSuccess: (result) {
        accountNameController.text = result.data?.accountName ?? '';
        numberController.text = result.data?.accountNumber ?? '';
        bankNameController.text = result.data?.bankName ?? '';
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    if (AppStorage.isUser == 'USER') {
      getUserBankAccount();
    } else {
      getBankDetails();
    }
  }
}