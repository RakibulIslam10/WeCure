import '../../../core/utils/app_storage.dart';
import '../../../core/utils/basic_import.dart';
import '../../../core/api/services/api_request.dart';
import '../../../core/api/end_point/api_end_points.dart';
import '../model/doctor_appoinment_model.dart';
import '../model/user_all_appoinment.dart';

class AppointmentController extends GetxController {

  final isUserLoading = false.obs;
  final isDoctorLoading = false.obs;

  final userAppointments = Rxn<UserAllAppointment>();
  final doctorAppointments = Rxn<DoctorAppointmentsModel>();

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  void _initData() {
    if (AppStorage.isUser == 'USER') {
      fetchUserAppointments();
    } else {
      fetchDoctorAppointments();
    }
  }

  Future<void> fetchUserAppointments() async {
    await ApiRequest().get(
      fromJson: UserAllAppointment.fromJson,
      endPoint: ApiEndPoints.appointments,
      isLoading: isUserLoading,
      onSuccess: (result) {
        userAppointments.value = result;
      },
    );
  }

  Future<void> fetchDoctorAppointments() async {
    await ApiRequest().get(
      fromJson: DoctorAppointmentsModel.fromJson,
      endPoint: ApiEndPoints.doctorAppointments,
      isLoading: isDoctorLoading,
      onSuccess: (result) {
        doctorAppointments.value = result;
      },
    );
  }

  void handleAppointmentAction(dynamic appointment) {
    final status = appointment.status?.toUpperCase() ?? '';

    if (status == 'ONGOING') {
      joinVideoCall(appointment.id);
    } else {
      openChat(appointment.id);
    }
  }

  void joinVideoCall(String appointmentId) {
    Get.toNamed(
      Routes.videoCallScreen,
      arguments: {
        'appointmentId': appointmentId,
      },
    );
  }

  void openChat(String appointmentId) {
    Get.toNamed(
      Routes.inboxScreen,
      arguments: {
        'appointmentId': appointmentId,
      },
    );
  }
}