import 'package:flutter/material.dart';
import 'package:honey_mobile/models/user/account-setting.dart';
import 'package:honey_mobile/models/user/notification-setting.dart';
import 'package:honey_mobile/models/user/search-setting.dart';
import 'package:honey_mobile/models/user/users.dart';
import 'package:honey_mobile/services/user.dart';

class UserSettingViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<double> coordinates = [];
  SearchSetting? searchSetting;
  NotificationSetting? notificationSetting;
  AccountSetting? accountSetting;
  UserService userService = UserService();
  String phoneNumber = "";
  String email = "";
  String countryCode = "";

  setSetting(User? user) {
    searchSetting = user!.search_setting;
    accountSetting = user.account_setting;
    notificationSetting = user.notification_setting;
    coordinates = user.coordinates!;
    phoneNumber = user.phone_number;
    countryCode = user.country_code;
    email = user.email!;
  }

  Future<void> update(BuildContext context, String accessToken) async {
    try {
      isLoading = true;
      notifyListeners();

      Map<String, dynamic> body = {
        'email': email,
        'phone_number': phoneNumber,
        'country_code': countryCode,
        'account_setting': accountSetting,
        'search_setting': searchSetting,
        'notification_setting': notificationSetting,
      };
      await userService.updateSetting(accessToken, body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Success update user setting!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 5),
      ));
    } catch (e) {
      print("error update user setting $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Fail to save setting!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 5),
      ));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
