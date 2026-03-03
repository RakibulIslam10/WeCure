import 'dart:developer';
import 'package:agora_chat_sdk/agora_chat_sdk.dart' hide MessageType;
import 'package:dio/dio.dart';
import 'package:http/http.dart' hide MultipartFile;
import 'package:image_picker/image_picker.dart';
import '../../../core/utils/app_storage.dart';
import '../../../core/utils/basic_import.dart' hide FormData, MultipartFile;
import '../../../core/api/services/api_request.dart';
import '../../../core/api/end_point/api_end_points.dart';
import '../model/chat_message_model.dart';
import '../model/inbox_args_model.dart';
import '../model/chat_token_model.dart';

class InboxController extends GetxController {
  final textController = TextEditingController();
  final scrollController = ScrollController();
  late final InboxArgsModel args;

  final RxBool shouldAutoScroll = true.obs;
  final RxBool isLoading = false.obs;
  final int maxImageCount = 5;

  RxList<ChatMessageModel> messagesList = <ChatMessageModel>[].obs;
  final RxList<XFile> multipleImages = <XFile>[].obs;

  final String myId = AppStorage.userId;
  late String appointmentId;
  late String receiverId;
  late String conversationId;

  ChatConversation? currentConversation;

  @override
  void onInit() {
    super.onInit();
    args = InboxArgsModel.fromMap(Get.arguments);
    appointmentId = args.appointmentId ?? '';
    receiverId = args.receiverId;
    conversationId = appointmentId; // Using appointmentId as conversationId

    initializeChat();
  }

  // ✅ Initialize Agora Chat
  Future<void> initializeChat() async {
    try {
      // Get chat token from backend
      await getChatTokenAndLogin();

      setupMessageListener();

      // Load old messages
      await loadOldMessages();
    } catch (e) {
      print('❌ Chat initialization error: $e');
      CustomSnackBar.error('Failed to initialize chat');
    }
  }

  // ✅ Get Chat Token from Backend
  Future<void> getChatTokenAndLogin() async {
    await ApiRequest().get(
      fromJson: ChatTokenModel.fromJson,
      endPoint: '/appointments/$appointmentId/chat/token',
      isLoading: isLoading,
      showResponse: true,
      onSuccess: (ChatTokenModel result) async {
        try {
          // Login to Agora Chat
          await ChatClient.getInstance.loginWithAgoraToken(
            myId,
            result.data.token,
          );
          print('✅ Agora Chat logged in');
        } on ChatError catch (e) {
          print('❌ Login failed: ${e.code}, ${e.description}');
        }
      },
    );
  }

  // ✅ Setup Message Listener
  void setupMessageListener() {
    ChatClient.getInstance.chatManager.addEventHandler(
      "CHAT_HANDLER_$appointmentId",
      ChatEventHandler(
        onMessagesReceived: (messages) {
          for (var msg in messages) {
            if (msg.conversationId == conversationId) {
              _addMessageToList(msg, isMe: false);
            }
          }
          shouldAutoScroll.value = true;
        },
        onMessagesRead: (messages) {
          // Handle read receipts
          for (var msg in messages) {
            final index = messagesList.indexWhere(
                  (m) => m.senderId == msg.msgId,
            );
            if (index != -1) {
              messagesList[index] = messagesList[index].copyWith(isSeen: true);
            }
          }
          messagesList.refresh();
        },
      ),
    );
  }

  // ✅ Load Old Messages
  Future<void> loadOldMessages() async {
    try {
      isLoading.value = true;

      currentConversation = await ChatClient.getInstance.chatManager
          .getConversation(conversationId);

      if (currentConversation != null) {
        List<ChatMessage> messages = await currentConversation!.loadMessages(
          loadCount: 50,
        );

        for (var msg in messages.reversed) {
          _addMessageToList(msg, isMe: msg.from == myId);
        }
      }

      isLoading.value = false;
    } catch (e) {
      print('❌ Error loading messages: $e');
      isLoading.value = false;
    }
  }

  // ✅ Add Message to List
  void _addMessageToList(ChatMessage msg, {required bool isMe}) {
    List<String> imagesList = [];
    String textContent = '';

    if (msg.body is ChatTextMessageBody) {
      textContent = (msg.body as ChatTextMessageBody).content;
    } else if (msg.body is ChatImageMessageBody) {
      final imageBody = msg.body as ChatImageMessageBody;
      imagesList.add(imageBody.remotePath ?? '');
    }

    messagesList.add(ChatMessageModel(
      isMe: isMe,
      type: imagesList.isNotEmpty ? MessageType.image : MessageType.text,
      message: textContent,
      images: imagesList,
      senderId: msg.msgId,
      isUploading: false,
      isSeen: msg.hasReadAck,
      createdAt: DateTime.fromMillisecondsSinceEpoch(msg.serverTime),
    ));
  }

  // ✅ Send Message
  void sendMessage() {
    if (textController.text.trim().isEmpty && multipleImages.isEmpty) return;

    if (multipleImages.isNotEmpty) {
      sendMessageWithImages();
    } else {
      sendTextMessage();
    }
  }

  // ✅ Send Text Message
  Future<void> sendTextMessage() async {
    final text = textController.text.trim();
    final tempId = DateTime.now().millisecondsSinceEpoch.toString();

    // Add to UI immediately
    messagesList.add(ChatMessageModel(
      isMe: true,
      senderId: tempId,
      type: MessageType.text,
      message: text,
    ));

    textController.clear();
    shouldAutoScroll.value = true;

    // Send via Agora
    try {
      var msg = ChatMessage.createTxtSendMessage(
        targetId: conversationId,
        content: text,
      );

      msg.chatType = ChatType.GroupChat; // Use GroupChat for appointment conversations

      await ChatClient.getInstance.chatManager.sendMessage(msg);
    } on ChatError catch (e) {
      print('❌ Send message error: ${e.code}, ${e.description}');
      CustomSnackBar.error('Failed to send message');
    }
  }

  // ✅ Send Message with Images
  Future<void> sendMessageWithImages() async {
    final tempId = DateTime.now().millisecondsSinceEpoch.toString();

    messagesList.add(ChatMessageModel(
      isMe: true,
      senderId: tempId,
      type: MessageType.image,
      message: textController.text.trim(),
      isUploading: true,
    ));

    shouldAutoScroll.value = true;

    // Upload images
    final List<String> uploadedImagePaths = await uploadImages(multipleImages);

    if (uploadedImagePaths.isEmpty) {
      CustomSnackBar.error('Failed to upload images');
      messagesList.removeWhere((msg) => msg.senderId == tempId);
      return;
    }

    // Update UI with uploaded images
    final messageIndex = messagesList.indexWhere((msg) => msg.senderId == tempId);
    if (messageIndex != -1) {
      messagesList[messageIndex] = messagesList[messageIndex].copyWith(
        images: uploadedImagePaths,
        isUploading: false,
      );
      messagesList.refresh();
    }

    // Send images via Agora
    try {
      for (var imagePath in uploadedImagePaths) {
        var msg = ChatMessage.createImageSendMessage(
          targetId: conversationId,
          filePath: imagePath,
        );

        msg.chatType = ChatType.GroupChat;

        await ChatClient.getInstance.chatManager.sendMessage(msg);
      }

      // Send text if any
      if (textController.text.trim().isNotEmpty) {
        await sendTextMessage();
      }
    } on ChatError catch (e) {
      print('❌ Send image error: ${e.code}, ${e.description}');
      CustomSnackBar.error('Failed to send images');
    }

    textController.clear();
    multipleImages.clear();
  }

  // ✅ Upload Images (Keep your existing upload logic)
  Future<List<String>> uploadImages(List<XFile> images) async {
    // ... keep your existing uploadImages implementation ...
    // (copy from your current code)
    return [];
  }

  void onEmojiSelect(String emoji) {
    textController.text += emoji;
    textController.selection = TextSelection.fromPosition(
      TextPosition(offset: textController.text.length),
    );
  }

  @override
  void onClose() {
    ChatClient.getInstance.chatManager.removeEventHandler("CHAT_HANDLER_$appointmentId");
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}