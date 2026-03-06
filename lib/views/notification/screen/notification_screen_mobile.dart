part of 'notification_screen.dart';

class NotificationScreenMobile extends GetView<NotificationController> {
  const NotificationScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Notification"),
      body: Obx(
        () => controller.isLoading.value
            ? LoadingWidget()
            : controller.notifications.isEmpty ? EmptyDataWidget(
          massage: 'You have no notification yet',
        ) : SafeArea(
          child: ListView.builder(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: Dimensions.defaultHorizontalSize,
              vertical: Dimensions.verticalSize * 0.5,
            ),
            itemCount: controller.notifications.length,
            addRepaintBoundaries: true,
            cacheExtent: 500,
            shrinkWrap: true,
            primary: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: Dimensions.heightSize),
                decoration: BoxDecoration(
                  color: Color(0xffF8F8F8),
                  borderRadius: BorderRadius.circular(
                    Dimensions.radius * 1.5,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.defaultHorizontalSize,
                    vertical: Dimensions.verticalSize * 0.25,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsetsGeometry.zero,
                    title: TextWidget(
                      controller.notifications[index].title,
                      fontWeight: FontWeight.w500,
                    ),
                    subtitle: TextWidget(
                      controller.notifications[index].message,
                      color: CustomColors.blackColor.withOpacity(0.6),
                      fontSize: Dimensions.titleSmall,

                      fontWeight: FontWeight.w500,
                    ),
                    trailing: TextWidget(
                      DateFormat(
                        'hh:mm a',
                      ).format(controller.notifications[index].createdAt),
                      fontSize: Dimensions.titleSmall,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
