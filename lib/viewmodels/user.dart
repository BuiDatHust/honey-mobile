import 'package:flutter/material.dart';
import 'package:honey_mobile/models/auth/token.dart';
import 'package:honey_mobile/models/user/users.dart';
import 'package:honey_mobile/services/token.dart';
import 'package:honey_mobile/services/user.dart';

class UserViewModel extends ChangeNotifier {
  bool isLoading = false;
  late UserService userService;
  late TokenService tokenService;
  User? user;

  Future<void> getPersonalUserInfo(
      String accessToken, BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      if (accessToken == "") {
        Token token = await tokenService.getToken();
        accessToken = token.access_token;
      }

      if (accessToken != "") {
        print("access $accessToken");
        User? data = await userService.getPersonalUserInfo(accessToken);
        print(data);
        if (data == null) {
          return;
        }
        user = data;
        notifyListeners();
      }
    } catch (e) {
      print("error get personal $e");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(e.toString()),
      //   backgroundColor: Theme.of(context).colorScheme.primary,
      //   duration: const Duration(seconds: 10),
      // ));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  setService(UserService newUserService, TokenService newTokenService) {
    userService = newUserService;
    tokenService = newTokenService;
  }
}
