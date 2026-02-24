import 'package:glady/core/api/end_point/api_end_points.dart';
import 'package:glady/core/api/services/api_request.dart';

import '../../../core/utils/basic_import.dart';
import '../model/appoinment_details_model.dart';

class AppointmentDetailsController extends GetxController {
  String appointmentId = '';

  @override
  void onInit() {
    super.onInit();
    appointmentId = Get.arguments;
  }

  RxBool isLoading = false.obs;

   DoctorAppointmentDetailsModel? doctorAppointmentDetailsModel;

  Future<DoctorAppointmentDetailsModel> fetchDoctorAppointmentDetails() async {
    return await ApiRequest().get(
      fromJson: DoctorAppointmentDetailsModel.fromJson,
      endPoint: ApiEndPoints.doctorAppointmentDetails,
      isLoading: isLoading,
      id: appointmentId,
      onSuccess: (result) {
        doctorAppointmentDetailsModel = result;
      },
    );
  }




}
