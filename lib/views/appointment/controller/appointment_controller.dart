import '../../../core/utils/app_storage.dart';
import '../../../core/utils/basic_import.dart';
import '../../../core/api/services/api_request.dart';
import '../../../core/api/end_point/api_end_points.dart';
import '../model/user_all_appoinment.dart';


class AppointmentController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    if (AppStorage.isUser == 'USER') {
      fetchUserAppointments();
    }
  }

  RxBool isLoading = false.obs;
  Rx<UserAllAppointment?> userAppointments = Rx<UserAllAppointment?>(null);

  Future<void> fetchUserAppointments() async {
    await ApiRequest().get(
      fromJson: UserAllAppointment.fromJson,
      endPoint: ApiEndPoints.appointments,
      isLoading: isLoading,
      showResponse: true,
      onSuccess: (result) {
        userAppointments.value = result;
      },
    );
  }

  void handleAppointmentAction(Appointments appointment) {
    final status = appointment.status.toUpperCase();

    if (status == 'ONGOING') {
      joinVideoCall(appointment);
    } else {
      openChat(appointment);
    }
  }

  void joinVideoCall(Appointments appointment) {
    Get.toNamed(
      Routes.videoCallScreen,
      arguments: {
        'appointmentId': appointment.id,
        'userId': 123,
      },
    );
  }

  void openChat(Appointments appointment) {
    Get.toNamed(Routes.inboxScreen);
  }
}