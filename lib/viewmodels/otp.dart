import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:honey_mobile/services/otp.dart';
import 'package:honey_mobile/views/authentication/verify-otp.dart';

class OtpViewModel extends ChangeNotifier {
  bool isLoading = false;
  late OtpService otpService;

  Future<void> resendLoginOtp(String phoneNumber, String countryCode,
      String typeOtp, String otpUsecase, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    Response<dynamic>? response =
        await otpService.sendOtp(phoneNumber, countryCode);

    if (response == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Fail to send OTP'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ));
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> sendLoginOtp(String phoneNumber, String countryCode,
      String typeOtp, String otpUsecase, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    Response<dynamic>? response =
        await otpService.sendOtp(phoneNumber, countryCode);

    if (response != null) {
      isLoading = false;
      notifyListeners();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VerifyOtpPage(
                  phnNumber: phoneNumber,
                  countryCode: countryCode,
                  typeOtp: typeOtp,
                  otpUsecase: otpUsecase,
                )),
      );
      return;
    }

    isLoading = false;
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Fail to send otp!'),
      backgroundColor: Theme.of(context).colorScheme.primary,
      duration: const Duration(seconds: 5),
    ));
  }

  Future<void> sendSignUpOtp(String phoneNumber, String countryCode,
      String typeOtp, String otpUsecase, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    Response<dynamic>? response =
        await otpService.sendOtp(phoneNumber, countryCode);

    if (response != null) {
      isLoading = false;
      notifyListeners();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VerifyOtpPage(
                  phnNumber: phoneNumber,
                  countryCode: countryCode,
                  typeOtp: typeOtp,
                  otpUsecase: otpUsecase,
                )),
      );
      return;
    }

    isLoading = false;
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Fail to send otp!'),
      backgroundColor: Theme.of(context).colorScheme.primary,
      duration: const Duration(seconds: 5),
    ));
  }

  setService(OtpService otpService) {
    this.otpService = otpService;
  }
}
