import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:honey_mobile/core/constants/otp.dart';
import 'package:honey_mobile/main.dart';
import 'package:honey_mobile/models/auth/token.dart';
import 'package:honey_mobile/services/otp.dart';
import 'package:honey_mobile/services/token.dart';
import 'package:honey_mobile/views/welcome/welcome-onboard.dart';

class TokenViewModel extends ChangeNotifier {
  bool isLoading = false;
  bool isTokenLoading = false;
  late Token token =
      const Token(access_token: "", refresh_token: "", device_id: "");
  late OtpService otpService;
  late TokenService tokenService;
  List<double> location = [];

  Future<void> requestLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition();
    location = [position.longitude, position.latitude];
  }

  setService(OtpService otpService, TokenService tokenService) {
    this.otpService = otpService;
    this.tokenService = tokenService;
  }

  Future<void> setToken() async {
    try {
      isTokenLoading = true;
      notifyListeners();
      Token newToken = await tokenService.getToken();
      token = newToken;
      isTokenLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      isTokenLoading = false;
      notifyListeners();
    }
  }

  Future<void> verifyLoginOtp(
      String phoneNumber,
      String countryCode,
      String typeOtp,
      String otpUsecase,
      String code,
      BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      Token? response;

      if (otpUsecase == OTP_USECASE[MANUAL_LOGIN_ACCOUNT]) {
        Token token = await tokenService.getToken();

        response = await otpService.verifyLoginOtp(
            phoneNumber, countryCode, code, location, token.device_id);
        if (response == null) {
          return;
        }
        token = response;
        await tokenService.saveTokenToLocalDevice(token);
      }
      if (otpUsecase == OTP_USECASE[REGISTER_ACCOUNT]) {
        await otpService.verifyRegisterOtp(phoneNumber, countryCode, code);
      }

      notifyListeners();
      if (otpUsecase == OTP_USECASE[MANUAL_LOGIN_ACCOUNT]) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      }
      if (otpUsecase == OTP_USECASE[REGISTER_ACCOUNT]) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WelcomeOnboardPage()),
        );
      }
    } catch (e) {
      print("error verifyLoginOtp $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 5),
      ));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
