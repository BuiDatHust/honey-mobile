import 'package:flutter/material.dart';
import 'package:honey_mobile/models/api-cursor-paginate-response.dart';
import 'package:honey_mobile/models/matching/chat.dart';
import 'package:honey_mobile/services/chat.dart';

class ChatListViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? cursor;
  bool has_more = false;
  List<Chat> chats = [];
  late ChatService chatService;

  Future<void> getListChat(BuildContext context, String accessToken) async {
    isLoading = true;
    notifyListeners();

    try {
      ApiCursorPaginateResponse<Chat> result =
          await chatService.getChatList(accessToken, 20, cursor);
      cursor = result.pagination.next_cursor;
      has_more = result.pagination.has_more;
      chats = result.data;
      print(chats);
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
