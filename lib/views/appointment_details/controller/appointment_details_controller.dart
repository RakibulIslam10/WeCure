import 'package:glady/core/api/end_point/api_end_points.dart';
import 'package:glady/core/api/model/basic_success_model.dart';
import 'package:glady/core/api/services/api_request.dart';
import 'package:glady/core/utils/app_storage.dart';

import '../../../core/utils/basic_import.dart';
import '../model/appoinment_details_model.dart';
import '../model/user_appoinment_details_model.dart';

class AppointmentDetailsController extends GetxController {
  late String appointmentId = '';
  final reasonController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    appointmentId = Get.arguments;

    if (AppStorage.isUser == 'USER') {
      fetchUserAppointmentDetails();
    } else {
      fetchDoctorAppointmentDetails();
    }
  }

  RxBool isLoading = false.obs;
  Rx<DoctorAppointmentDetailsModel?> doctorAppointmentDetailsModel =
      Rx<DoctorAppointmentDetailsModel?>(null);

  Future<void> fetchDoctorAppointmentDetails() async {
    await ApiRequest().get(
      fromJson: DoctorAppointmentDetailsModel.fromJson,
      endPoint: ApiEndPoints.doctorAppointmentDetails,
      isLoading: isLoading,
      id: appointmentId,
      // showResponse: true,
      onSuccess: (result) {
        doctorAppointmentDetailsModel.value = result;
        print('✅ Data loaded: ${result.data.patient.name}'); // Debug
      },
    );
  }


  Rx<UserAppointmentDetailsModel?> userAppointmentDetailsModel =
  Rx<UserAppointmentDetailsModel?>(null);

  Future<void> fetchUserAppointmentDetails() async {
    await ApiRequest().get(
      fromJson: UserAppointmentDetailsModel.fromJson,
      endPoint: ApiEndPoints.userAppointmentDetails,
      isLoading: isLoading,
      id: appointmentId,
      showResponse: true,
      onSuccess: (result) {
        userAppointmentDetailsModel.value = result;
      },
    );
  }

  RxBool isDeleting = false.obs;

  Future<BasicSuccessModel> rejectAppointment() async {
    return ApiRequest().post(
      fromJson: BasicSuccessModel.fromJson,
      endPoint: '/appointments/doctor/$appointmentId/reject',
      isLoading: isDeleting,
      body: {'reason': reasonController.text.trim()},
      onSuccess: (result) {
        Get.offAllNamed(Routes.navigationScreen);
      },
    );
  }
}
