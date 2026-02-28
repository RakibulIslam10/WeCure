import 'package:glady/core/api/end_point/api_end_points.dart';
import 'package:glady/core/api/services/api_request.dart';

import '../../../core/utils/basic_import.dart';
import '../model/appoinment_details_model.dart';

class AppointmentDetailsController extends GetxController {
  late String appointmentId = '';

  @override
  void onInit() {
    super.onInit();
    appointmentId = Get.arguments;
    fetchDoctorAppointmentDetails();
  }

  RxBool isLoading = false.obs;
  Rx<DoctorAppointmentDetailsModel?> doctorAppointmentDetailsModel = Rx<DoctorAppointmentDetailsModel?>(null);

  Future<void> fetchDoctorAppointmentDetails() async {
    await ApiRequest().get(
      fromJson: DoctorAppointmentDetailsModel.fromJson,
      endPoint: ApiEndPoints.doctorAppointmentDetails,
      isLoading: isLoading,
      id: appointmentId,
      showResponse: true,
      onSuccess: (result) {
        doctorAppointmentDetailsModel.value = result;
        print('✅ Data loaded: ${result.data.patient.name}'); // Debug
      },
    );
  }
}