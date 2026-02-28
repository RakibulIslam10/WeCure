import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/api/services/api_request.dart';
import '../../../core/api/model/basic_success_model.dart';
import '../../../core/utils/basic_import.dart';
import '../../../core/widgets/confirmation_widget.dart';

class SupportController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Rx<XFile?> attachment = Rx<XFile?>(null);
  RxBool isLoading = false.obs;

  Future<BasicSuccessModel> sendSupport() async {
    return ApiRequest().multiMultipartRequest(
      reqType: 'POST',
      fromJson: BasicSuccessModel.fromJson,
      endPoint: ApiEndPoints.support,
      isLoading: isLoading,
      body: {
        'name': nameController.text,
        'email': emailController.text.trim(),
        'message': messageController.text,
      },
      // showSuccessSnackBar: true,
      files: attachment.value != null
          ? {'attachment': File(attachment.value!.path)}
          : {},
      onSuccess: (result) {
        Get.offAll(
          ConfirmationWidget(
            iconPath: Assets.icons.vector,
            title: 'Submitted Successfully',
            subtitle: 'Your message has been sent successfully',
            onTap: () => Get.offAllNamed(Routes.navigationScreen),
          ),
        );
      },
    );
  }

}