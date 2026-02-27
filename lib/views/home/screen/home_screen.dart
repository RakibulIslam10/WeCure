import 'dart:math';

import 'package:glady/core/widgets/loading_widget.dart';
import 'package:glady/core/widgets/pagination_loader.dart';
import 'package:glady/core/widgets/profile_avater_widget.dart';
import 'package:glady/views/navigation/controller/navigation_controller.dart';
import 'package:glady/views/profile/controller/profile_controller.dart';
import 'package:glady/widgets/custom_logo_widget.dart';
import 'package:glady/widgets/doctor_card_widget.dart';
import 'package:shadify/shadify.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/app_storage.dart';
import '../../../core/utils/basic_import.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../../../widgets/section_header.dart';
import '../controller/home_controller.dart';
import '../widget/shimmer.dart';

part 'home_screen_mobile.dart';
part '../widget/my_app_bar_widget.dart';
part '../widget/search_header_widget.dart';
part '../widget/slider_item_widget.dart';
part '../widget/tips_card_widget.dart';
part '../widget/category_Section_widget.dart';
part '../widget/home_doctor_card_widget.dart';
part '../widget/bottom_banner_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: HomeScreenMobile());
  }
}
