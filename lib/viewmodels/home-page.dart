import 'package:flutter/material.dart';
import 'package:honey_mobile/models/api-cursor-paginate-response.dart';
import 'package:honey_mobile/models/api-response.dart';
import 'package:honey_mobile/models/profile/profile.dart';
import 'package:honey_mobile/models/profile/react-profile-response.dart';
import 'package:honey_mobile/services/profile.dart';

class HomePageViewModel extends ChangeNotifier {
  int index = 0;
  bool isLoading = false;
  String? cursor;
  bool has_more = false;
  List<Profile> users = [];
  ProfileService profileService = ProfileService();

  Future<void> getListProfile(BuildContext context, String accessToken) async {
    isLoading = true;
    notifyListeners();

    try {
      ApiCursorPaginateResponse<Profile> result = await profileService
          .getRecommendProfile(accessToken, false, 20, cursor);

      cursor = result.pagination.next_cursor;
      has_more = result.pagination.has_more;
      users = result.data;
      index = 0;
    } catch (e) {
      print("errror getListProfile $e");

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Fail to load profile!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 5),
      ));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  increaseIndex(BuildContext context, String accessToken) async {
    if (index == users.length - 1) {
      await getListProfile(context, accessToken);
      index = 0;
      notifyListeners();
      return;
    }

    index++;
    notifyListeners();
  }

  Future<void> react(
      BuildContext context, String accessToken, bool isLike) async {
    isLoading = true;
    notifyListeners();

    String typeReaction = isLike ? "LIKE" : "NOPE";
    String userId = users[index].id;
    try {
      ApiResponse<ReactProfileResponse> result = await profileService
          .reactProfile(accessToken, "SWIPE", userId, typeReaction);

      if (result.data!.is_matching) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Congratulation, it is a match!'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          duration: const Duration(seconds: 5),
        ));
      }
    } catch (e) {
      print("errror getListProfile $e");

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Fail to load profile!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 5),
      ));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
