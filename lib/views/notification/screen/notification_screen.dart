import 'package:glady/core/widgets/empty_data_widget.dart';
import 'package:glady/core/widgets/loading_widget.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/basic_import.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../controller/notification_controller.dart';

part 'notification_screen_mobile.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: NotificationScreenMobile());
  }
}
