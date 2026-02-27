import 'package:glady/core/widgets/empty_data_widget.dart';
import 'package:glady/core/widgets/loading_widget.dart';
import 'package:glady/core/widgets/pagination_loader.dart';

import '../../../core/utils/basic_import.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../../../widgets/doctor_details_card.dart';
import '../../../widgets/section_header.dart';
import '../../doctor_details/widget/booking_dialog.dart';
import '../controller/category_details_controller.dart';
import '../widget/category_dialog.dart';

part 'category_details_screen_mobile.dart';

class CategoryDetailsScreen extends GetView<CategoryDetailsController> {
  const CategoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: CategoryDetailsScreenMobile());
  }
}
