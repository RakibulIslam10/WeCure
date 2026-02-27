import 'package:glady/core/widgets/pagination_loader.dart';

import '../../../core/utils/basic_import.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../../../core/widgets/loading_widget.dart';
import '../controller/all_category_controller.dart';

part 'all_category_screen_mobile.dart';

class AllCategoryScreen extends GetView<AllCategoryController> {
  const AllCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: AllCategoryScreenMobile());
  }
}
