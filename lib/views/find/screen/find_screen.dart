import 'package:flutter/cupertino.dart';

import '../../../core/utils/basic_import.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../../../core/widgets/empty_data_widget.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../widgets/doctor_details_card.dart';
import '../controller/find_controller.dart';

part 'find_screen_mobile.dart';

class FindScreen extends GetView<FindController> {
  const FindScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: FindScreenMobile());
  }
}
