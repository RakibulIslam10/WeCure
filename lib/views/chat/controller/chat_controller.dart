import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import '../../../core/utils/app_storage.dart';
import '../../../core/utils/basic_import.dart';

import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import '../../../core/utils/basic_import.dart';
import '../../../core/api/services/api_request.dart';
import '../../../core/api/end_point/api_end_points.dart';
import '../../appointment/model/user_all_appoinment.dart';
import '../../inbox/model/chat_token_model.dart';

class ChatController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isChatInitialized = false.obs;
  RxList<ChatConversation> conversations = <ChatConversation>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (AppStorage.isUser == 'USER') {
      initializeAgoraChat();
    }
  }

  // ✅ Initialize Agora Chat
  Future<void> initializeAgoraChat() async {
    try {
      ChatOptions options = ChatOptions(
        appKey: "ede37afa88f7457bb0d8442b1cb0a588",
        autoLogin: false,
      );

      await ChatClient.getInstance.init(options);
      await loginToAgora();
      await loadChatList();

      isChatInitialized.value = true;
    } catch (e) {
      print('❌ Chat initialization error: $e');
    }
  }

  // ✅ Login to Agora Chat
  Future<void> loginToAgora() async {
    try {
      final userId = AppStorage.userId;
      final token = await getChatToken();

      if (token.isEmpty) {
        print('⚠️ Chat token is empty');
        return;
      }

      await ChatClient.getInstance.loginWithAgoraToken(userId, token);
      print('✅ Agora Chat login successful');
    } on ChatError catch (e) {
      print('❌ Agora Chat login failed: ${e.code}, ${e.description}');

      if (e.code == 200) {
        // Already logged in
        print('✅ Already logged in to Agora Chat');
      } else {
        CustomSnackBar.error('Failed to connect to chat');
      }
    }
  }

  // ✅ Get Chat Token from Backend
  Future<String> getChatToken() async {
    String token = '';

    try {
      // Get user's appointments first
      final appointments = await fetchUserAppointments();

      if (appointments.isEmpty) {
        print('⚠️ No appointments found to get chat token');
        return '';
      }

      // Use first appointment to get chat token
      final firstAppointmentId = appointments.first.id;

      await ApiRequest().get(
        fromJson: ChatTokenModel.fromJson,
        endPoint: '/appointments/$firstAppointmentId/chat/token',
        showResponse: true,
        onSuccess: (ChatTokenModel result) {
          token = result.data.token;
          print('✅ Chat token received');
        }, isLoading: isLoading,
      );

      return token;
    } catch (e) {
      print('❌ Error getting chat token: $e');
      return '';
    }
  }



  // ✅ Fetch User Appointments
  Future<List<Appointments>> fetchUserAppointments() async {
    List<Appointments> appointments = [];

    await ApiRequest().get(
      fromJson: (json) => json,
      endPoint: ApiEndPoints.appointments,
      onSuccess: (result) {
        if (result['data'] != null) {
          appointments = (result['data'] as List)
              .map((e) => Appointments.fromJson(e))
              .toList();
        }
      }, isLoading: isLoading,
    );

    return appointments;
  }

  // ✅ Load Chat List
  Future<void> loadChatList() async {
    try {
      isLoading.value = true;

      List<ChatConversation> allConversations =
      await ChatClient.getInstance.chatManager.loadAllConversations();

      conversations.value = allConversations;
      isLoading.value = false;

      print('✅ Loaded ${allConversations.length} conversations');
    } catch (e) {
      print('❌ Error loading conversations: $e');
      isLoading.value = false;
    }
  }

  // ✅ Refresh Chat List
  Future<void> refreshChatList() async {
    await loadChatList();
  }

  @override
  void onClose() {
    try {
      ChatClient.getInstance.logout();
    } catch (e) {
      print('Error logging out: $e');
    }
    super.onClose();
  }
}