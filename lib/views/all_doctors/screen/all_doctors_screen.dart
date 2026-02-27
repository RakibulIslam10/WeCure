import 'package:glady/core/widgets/loading_widget.dart';

import '../../../core/utils/basic_import.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../../../core/widgets/pagination_loader.dart';
import '../../../widgets/doctor_card_widget.dart';
import '../controller/all_doctors_controller.dart';

part 'all_doctors_screen_mobile.dart';

class AllDoctorsScreen extends GetView<AllDoctorsController> {
  const AllDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: AllDoctorsScreenMobile());
  }
}
