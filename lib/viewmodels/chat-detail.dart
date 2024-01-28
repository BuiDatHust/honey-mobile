import 'package:flutter/material.dart';
import 'package:honey_mobile/models/matching/chat.dart';
import 'package:honey_mobile/services/chat.dart';

class ChatDetailViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? cursor;
  bool has_more = false;
  Chat? chat;
  late ChatService chatService;

  Future<void> getDetailChat(
      BuildContext context, String chatId, String accessToken) async {
    isLoading = true;
    notifyListeners();

    try {
      Chat? result = await chatService.getDetailChat(accessToken, chatId);
      chat = result;
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  setService(ChatService newChatService) {
    chatService = newChatService;
  }
}
