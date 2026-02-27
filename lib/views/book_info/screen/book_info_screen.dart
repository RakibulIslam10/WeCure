import 'dart:io';

import 'package:glady/core/widgets/bottom_sheet_dialog_widget.dart';
import 'package:glady/core/widgets/loading_widget.dart';

import '../../../core/utils/basic_import.dart';
import '../../../core/widgets/bottom_image_picker.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../controller/book_info_controller.dart';

part 'book_info_screen_mobile.dart';
part '../widget/attachment_add_widget.dart';

class BookInfoScreen extends GetView<BookInfoController> {
  const BookInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: BookInfoScreenMobile());
  }
}
