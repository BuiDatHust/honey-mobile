import 'package:flutter/material.dart';
import 'package:honey_mobile/models/api-cursor-paginate-response.dart';
import 'package:honey_mobile/models/matching/friend.dart';
import 'package:honey_mobile/services/friend.dart';

class NewFriendViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? cursor;
  bool has_more = false;
  List<Friend> friends = [];
  late FriendService friendService;

  Future<void> getListNewFriend(
      BuildContext context, String accessToken) async {
    isLoading = true;
    notifyListeners();

    try {
      ApiCursorPaginateResponse<Friend> result =
          await friendService.getAllFriend(accessToken, true, 20, cursor);
      cursor = result.pagination.next_cursor;
      has_more = result.pagination.has_more;
      friends = result.data;
    } catch (e) {
      print(" error getListNewFriend $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  setService(FriendService newFriendService) {
    friendService = newFriendService;
  }
}
