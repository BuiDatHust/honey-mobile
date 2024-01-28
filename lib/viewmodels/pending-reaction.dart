import 'package:flutter/material.dart';
import 'package:honey_mobile/core/constants/matching.dart';
import 'package:honey_mobile/models/api-cursor-paginate-response.dart';
import 'package:honey_mobile/models/matching/pending-reaction.dart';
import 'package:honey_mobile/services/friend.dart';

class PendingReactionModel extends ChangeNotifier {
  bool isEveryOneLoading = false;
  bool isMeLoading = false;
  bool hasMoreEveryonePending = false;
  String? cursorEveryonePending;
  bool hasMoreMePending = false;
  String? cursorMePending;
  List<PendingReaction> everyonePendingReactions = [];
  List<PendingReaction> mePendingReactions = [];
  late FriendService friendService;

  Future<void> getPendingReaction(BuildContext context, String accessToken,
      String typePendingReaction) async {
    setLoading(true, typePendingReaction);
    notifyListeners();

    try {
      String? cursor = typePendingReaction == MatchingConstant.EVERYONE_PENDING
          ? cursorEveryonePending
          : cursorMePending;
      ApiCursorPaginateResponse<PendingReaction> result = await friendService
          .getPendingReaction(accessToken, cursor, 20, typePendingReaction);

      setLoading(false, typePendingReaction);
      if (typePendingReaction == MatchingConstant.EVERYONE_PENDING) {
        hasMoreEveryonePending = result.pagination.has_more;
        cursorEveryonePending = result.pagination.next_cursor;
      } else {
        hasMoreMePending = result.pagination.has_more;
        cursorMePending = result.pagination.next_cursor;
      }
      setPendingReation(result.data, typePendingReaction);
      notifyListeners();
    } catch (e) {
      print("error get pending reaction $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 10),
      ));
    } finally {
      setLoading(false, typePendingReaction);
      notifyListeners();
    }
  }

  setLoading(bool isLoading, String typePendingReaction) {
    if (typePendingReaction == MatchingConstant.EVERYONE_PENDING) {
      isEveryOneLoading = isLoading;
    } else {
      isMeLoading = isLoading;
    }
  }

  setPendingReation(
      List<PendingReaction> pendingReactions, String typePendingReaction) {
    if (typePendingReaction == MatchingConstant.EVERYONE_PENDING) {
      everyonePendingReactions = pendingReactions;
    } else {
      mePendingReactions = pendingReactions;
    }
  }

  setService(FriendService newFriendService) {
    friendService = newFriendService;
  }
}
