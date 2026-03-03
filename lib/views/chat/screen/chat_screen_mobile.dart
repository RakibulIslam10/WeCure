import 'package:glady/core/widgets/profile_avater_widget.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/basic_import.dart';
import '../../../core/widgets/loading_widget.dart';
import '../controller/chat_controller.dart';

import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:glady/core/widgets/profile_avater_widget.dart';
import '../../../core/utils/basic_import.dart';
import '../controller/chat_controller.dart';

class ChatScreenMobile extends StatelessWidget {
  ChatScreenMobile({super.key});

  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Chat',
        isBack: false,
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return LoadingWidget();
          }

          if (!controller.isChatInitialized.value) {
            return Center(
              child: Column(
                mainAxisAlignment: mainCenter,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 80.h,
                    color: CustomColors.grayShade,
                  ),
                  Space.height.v20,
                  TextWidget(
                    'Initializing chat...',
                    fontSize: Dimensions.titleMedium,
                    color: CustomColors.grayShade,
                  ),
                ],
              ),
            );
          }

          if (controller.conversations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: mainCenter,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 80.h,
                    color: CustomColors.grayShade,
                  ),
                  Space.height.v20,
                  TextWidget(
                    'No conversations yet',
                    fontSize: Dimensions.titleMedium,
                    color: CustomColors.grayShade,
                  ),
                  Space.height.v10,
                  TextWidget(
                    'Start chatting from your appointments',
                    fontSize: Dimensions.titleSmall,
                    color: CustomColors.grayShade,
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: controller.refreshChatList,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.defaultHorizontalSize,
              ),
              itemCount: controller.conversations.length + 1,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                // Search Bar
                if (index == 0) {
                  return Container(
                    margin: EdgeInsets.only(
                      bottom: Dimensions.heightSize * 2,
                      top: Dimensions.heightSize,
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
                        Icon(Icons.search_rounded,
                            color: CustomColors.primary),
                        Space.width.v5,
                        TextWidget(
                          "Search",
                          color: CustomColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  );
                }

                // Chat Item
                final conversation =
                controller.conversations[index - 1];

                return FutureBuilder<ChatMessage?>(
                  future: conversation.latestMessage(),
                  builder: (context, snapshot) {
                    final lastMessage = snapshot.data;
                    String lastMessageText = 'No messages yet';
                    String time = '';

                    if (lastMessage != null) {
                      if (lastMessage.body is ChatTextMessageBody) {
                        lastMessageText =
                            (lastMessage.body as ChatTextMessageBody)
                                .content;
                      } else if (lastMessage.body
                      is ChatImageMessageBody) {
                        lastMessageText = '📷 Image';
                      }

                      time = _formatTime(lastMessage.serverTime);
                    }

                    return Container(
                      margin: EdgeInsets.only(
                          bottom: Dimensions.heightSize),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: CustomColors.borderColor
                                .withOpacity(0.8)),
                        borderRadius: BorderRadius.circular(
                            Dimensions.radius * 1.5),
                      ),
                      child: ListTile(
                        onTap: () {
                          Get.toNamed(
                            Routes.inboxScreen,
                            arguments: {
                              'receiverId': conversation.id,
                              'appointmentId': conversation.id,
                              'name': conversation.id,
                              'avatar': '',
                            },
                          );
                        },
                        leading: ProfileAvatarWidget(
                          imageUrl:
                          'https://raw.githubusercontent.com/ai-py-auto/souce/refs/heads/main/Rectangle%202.png',
                        ),
                        title: TextWidget(
                          conversation.id,
                          fontWeight: FontWeight.bold,
                        ),
                        subtitle: TextWidget(
                          lastMessageText,
                          fontSize: Dimensions.titleSmall,
                          color: CustomColors.grayShade,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                        trailing: Column(
                          mainAxisAlignment: mainCenter,
                          crossAxisAlignment: crossEnd,
                          children: [
                            TextWidget(
                              time,
                              fontWeight: FontWeight.w400,
                              fontSize: Dimensions.titleSmall,
                              color: CustomColors.grayShade,
                            ),
                            FutureBuilder<int>(
                              future: conversation.unreadCount(),
                              builder: (context, snapshot) {

                                if (!snapshot.hasData || snapshot.data == 0) {
                                  return SizedBox();
                                }

                                return Container(
                                  margin: EdgeInsets.only(
                                    top: Dimensions.heightSize * 0.3,
                                  ),
                                  padding: EdgeInsets.all(6.w),
                                  decoration: BoxDecoration(
                                    color: CustomColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: TextWidget(
                                    snapshot.data.toString(),
                                    color: CustomColors.whiteColor,
                                    fontSize: Dimensions.labelSmall,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        }),
      ),
    );
  }

  String _formatTime(int timestamp) {
    final now = DateTime.now();
    final messageTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final difference = now.difference(messageTime);

    if (difference.inDays == 0) {
      return DateFormat('hh:mm a').format(messageTime);
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return DateFormat('EEE').format(messageTime);
    } else {
      return DateFormat('dd/MM/yy').format(messageTime);
    }
  }
}