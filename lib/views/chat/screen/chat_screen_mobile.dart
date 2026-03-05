import 'package:glady/core/widgets/loading_widget.dart';
import 'package:glady/core/widgets/profile_avater_widget.dart';
import '../../../core/utils/basic_import.dart';
import '../controller/chat_controller.dart';

class ChatScreenMobile extends StatelessWidget {
  ChatScreenMobile({super.key});

  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Chat', isBack: false),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) return const LoadingWidget();
          return Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.defaultHorizontalSize,
                  vertical: Dimensions.heightSize,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: CustomColors.borderColor),
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.defaultHorizontalSize,
                  vertical: Dimensions.verticalSize * 0.5,
                ),


                child: Row(
                  children: [
                    Icon(Icons.search_rounded, color: CustomColors.primary),
                    Space.width.v10,
                    Expanded(
                      child: TextField(
                        controller: controller.searchController,
                        onChanged: controller.onSearchChanged,
                        cursorColor: CustomColors.primary,
                        style: TextStyle(fontSize: Dimensions.titleSmall),
                        decoration: InputDecoration(
                          hintText: "Search by name...",

                          hintStyle: TextStyle(
                            color: CustomColors.secondaryDarkText,
                            fontSize: Dimensions.titleSmall,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    Obx(() => controller.searchQuery.value.isNotEmpty
                        ? GestureDetector(
                      onTap: () {
                        controller.searchController.clear();
                        controller.onSearchChanged('');
                      },
                      child: Icon(
                        Icons.close,
                        color: CustomColors.secondaryDarkText,
                        size: Dimensions.iconSizeLarge,
                      ),
                    )
                        : const SizedBox.shrink()),
                  ],
                ),
              ),

              // List
              Expanded(
                child: Obx(() {
                  final personData = controller.filteredList;

                  if (personData.isEmpty) {
                    return Center(
                      child: TextWidget(
                        controller.searchQuery.value.isNotEmpty
                            ? 'No results found for "${controller.searchQuery.value}"'
                            : 'No conversations yet',
                        color: CustomColors.secondaryDarkText,
                        fontSize: Dimensions.titleSmall,
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.defaultHorizontalSize,
                    ),
                    itemCount: personData.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = personData[index];
                      final participant = item.participants.isNotEmpty
                          ? item.participants.first
                          : null;
                      final lastMsg = item.lastMessage.text;
                      final time = _formatTime(item.lastMessage.createdAt);

                      return Container(
                        margin: EdgeInsets.only(bottom: Dimensions.heightSize),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: CustomColors.borderColor.withOpacity(0.8),
                          ),
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius * 1.5,
                          ),
                        ),
                        child: ListTile(
                          onTap: () {
                            Get.toNamed(
                              Routes.inboxScreen,
                              arguments: {
                                'conversationId': item.id,
                                'receiverId': participant?.id ?? '',
                                'receiverRole': participant?.role ?? '',
                                'avatar': participant?.image ?? '',
                                'name': participant?.name ?? '',
                              },
                            );
                          },
                          leading: ProfileAvatarWidget(
                            imageUrl: participant?.image,
                            size: 46,
                          ),
                          title: TextWidget(
                            participant?.name ?? '',
                            fontWeight: FontWeight.w600,
                            fontSize: Dimensions.titleSmall,
                          ),
                          subtitle: TextWidget(
                            lastMsg.isNotEmpty ? lastMsg : 'No messages yet',
                            fontWeight: FontWeight.w400,
                            fontSize: Dimensions.labelMedium,
                            color: CustomColors.secondaryDarkText,
                            textOverflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          trailing: Column(
                            mainAxisAlignment: mainCenter,
                            crossAxisAlignment: crossEnd,
                            children: [
                              TextWidget(
                                time,
                                fontWeight: FontWeight.w400,
                                fontSize: Dimensions.labelSmall,
                                color: CustomColors.secondaryDarkText,
                              ),
                              if (!item.lastMessage.seen) ...[
                                Space.height.v5,
                                Container(
                                  width: 8.w,
                                  height: 8.w,
                                  decoration: BoxDecoration(
                                    color: CustomColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          );
        }),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour % 12 == 0 ? 12 : hour % 12;
    return '$displayHour:$minute $period';
  }
}