import '../../../core/utils/basic_import.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/profile_avater_widget.dart';
import '../controller/all_review_controller.dart';

part 'all_review_screen_mobile.dart';

class AllReviewScreen extends GetView<AllReviewController> {
  const AllReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: AllReviewScreenMobile());
  }
}
