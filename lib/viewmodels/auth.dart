import 'package:flutter/material.dart';
import 'package:honey_mobile/main.dart';
import 'package:honey_mobile/services/auth.dart';
import 'package:honey_mobile/services/token.dart';

class AuthViewModel extends ChangeNotifier {
  bool isLoading = false;
  TokenService tokenService = TokenService();
  AuthService authService = AuthService();

  Future<void> logout(
      BuildContext context, String logoutType, String accessToken) async {
    isLoading = true;
    notifyListeners();

    try {
      await authService.logout(accessToken, logoutType);
      await tokenService.deleteTokenInLocal();
      notifyListeners();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
