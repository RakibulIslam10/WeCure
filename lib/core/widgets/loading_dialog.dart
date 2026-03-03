import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'loading_widget.dart';

// Show
// LoadingDialog.show();
// LoadingDialog.show(message: 'Uploading...');

// Hide
// LoadingDialog.hide();

class LoadingDialog {
  static void show({String message = 'Please wait...'}) {
    Get.dialog(
      CupertinoAlertDialog(
        content: Padding(
          padding: EdgeInsets.only(top: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const LoadingWidget(),
              SizedBox(height: 12),
              Text(message),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void hide() {
    if (Get.isDialogOpen ?? false) Get.back();
  }
}