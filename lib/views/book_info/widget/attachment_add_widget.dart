part of '../screen/book_info_screen.dart';

class AttachmentAddWidget extends GetView<BookInfoController> {
  const AttachmentAddWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Wrap(
        spacing: Dimensions.widthSize,
        runSpacing: Dimensions.heightSize,
        children: [

          ...List.generate(controller.selectedAttachments.length, (index) {
            final file = File(controller.selectedAttachments[index].path);
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CustomColors.disableColor.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(Dimensions.radius),
                  ),
                  height: 100.h,
                  width: 100.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.radius),
                    child: Image.file(file, fit: BoxFit.cover),
                  ),
                ),
                // Remove button
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => controller.removeAttachment(index),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(3.r),
                      child: Icon(Icons.close, size: 12.sp, color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          }),

          // Add button
          GestureDetector(
            onTap: () {
              BottomImagePicker.show(
                multiple: true,
                multipleImagesVariable: (images) {
                  controller.addAttachments(images);
                  return images;
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: CustomColors.disableColor.withOpacity(0.8),
                  width: 1.1,
                ),
                borderRadius: BorderRadius.circular(Dimensions.radius),
              ),
              height: 100.h,
              width: 100.w,
              child: Icon(Icons.add, size: 50.sp),
            ),
          ),
        ],
      ),
    );
  }
}