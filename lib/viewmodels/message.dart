import 'package:flutter/material.dart';
import 'package:honey_mobile/models/api-cursor-paginate-response.dart';
import 'package:honey_mobile/models/matching/message.dart';
import 'package:honey_mobile/services/message.dart';

class MessageViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<Message> messages = [];
  late MessageService messageService;
  String? cursor;
  bool has_more = false;

  Future<void> getMessages(String accessToken, String chatId) async {
    isLoading = true;
    notifyListeners();

    try {
      ApiCursorPaginateResponse<Message> result =
          await messageService.getListMessage(accessToken, 20, chatId, cursor);
      cursor = result.pagination.next_cursor;
      has_more = result.pagination.has_more;
      messages = result.data;
    } catch (e) {
      print("errror getMessages $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  setService(MessageService newMessageService) {
    messageService = newMessageService;
  }
}
