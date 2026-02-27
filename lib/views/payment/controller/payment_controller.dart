import 'package:flutter/cupertino.dart';
import 'package:glady/core/api/services/api_request.dart';

import '../../../core/utils/basic_import.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/webview_screen.dart';
import '../model/payment_model.dart';

class PaymentController extends GetxController {
  late String appointmentId;

  late String paymentUrl = '';

  RxList<String> attachmentList = [
    'https://www.corpnet.com/wp-content/uploads/2022/01/Legal-Document.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1jHgGzzR6mVeD6twgYu3-A2dHMTyyqcmP3A&s',
  ].obs;

  @override
  void onInit() {
    super.onInit();
    appointmentId = Get.arguments;
  }

  RxBool isLoading = false.obs;

  Future<void> makePayment() async {
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

    try {
      await ApiRequest().post(
        fromJson: PaymentModel.fromJson,
        endPoint: '/payments/appointments/$appointmentId/initialize',
        isLoading: isLoading,
        body: {},
        onSuccess: (result) {
          paymentUrl = result.data.authorizationUrl;
          debugPrint("🔗 Payment URL: ${result.data.authorizationUrl}");
        },
      );
    } catch (_) {
    } finally {
      if (Get.isDialogOpen ?? false) Get.back();
    }

    if (paymentUrl.isNotEmpty) {
      await Future.delayed(const Duration(milliseconds: 100));
      Get.to(() => WebPaymentScreen());
    }
  }
}
