import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:glady/core/api/end_point/api_end_points.dart';
import 'package:glady/core/widgets/loading_widget.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/api/model/basic_success_model.dart';
import '../../../core/api/services/api_request.dart';
import '../../../core/utils/basic_import.dart';
import '../../doctor_details/controller/doctor_details_controller.dart';

class BookInfoController extends GetxController {
  final reasonTitleController = TextEditingController();
  final reasonDetailsController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final RxList<XFile> selectedAttachments = <XFile>[].obs;

  RxBool isLoading = false.obs;

  void addAttachments(List<XFile> images) {
    selectedAttachments.addAll(images);
  }

  void removeAttachment(int index) {
    selectedAttachments.removeAt(index);
  }

  Future<void> bookAppointment() async {
    if (!formKey.currentState!.validate()) return;

    if (!formKey.currentState!.validate()) return;

    Get.dialog(
      const CupertinoAlertDialog(
        content: Padding(
          padding: EdgeInsets.only(top: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingWidget(),
              SizedBox(height: 12),
              Text('Please wait...'),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );


    final detailsController = Get.find<DoctorDetailsController>();
    final doctorId = detailsController.doctorId ?? '';
    final appointmentDate = detailsController.selectedDate.value;
    final appointmentTime = detailsController.selectedTime.value;

    if (doctorId.isEmpty || appointmentDate.isEmpty || appointmentTime.isEmpty) {
      CustomSnackBar.error('Please select date and time first');
      return;
    }

    final Map<String, File?> filesMap = {};
    final Map<String, dynamic> body = {
      'doctorId': doctorId,
      'appointmentDate': appointmentDate,
      'appointmentTime': appointmentTime,
      'reasonTitle': reasonTitleController.text.trim(),
      'reasonDetails': reasonDetailsController.text.trim(),
    };

    final filesList = <String, List<File>>{};
    if (selectedAttachments.isNotEmpty) {
      filesList['attachment'] =
          selectedAttachments.map((e) => File(e.path)).toList();
    }

    await ApiRequest().multiMultipartRequest(
      endPoint: ApiEndPoints.appointments,
      isLoading: isLoading,
      reqType: 'POST',
      body: body,
      files: filesMap,
      filesList: filesList,
      fromJson: BasicSuccessModel.fromJson,
      showSuccessSnackBar: true,
      onSuccess: (result) {
        Get.toNamed(Routes.paymentScreen);
      },
    );
  }
}