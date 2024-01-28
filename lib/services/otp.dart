import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:honey_mobile/core/constants/http.dart';
import 'package:honey_mobile/core/network/dio-exception.dart';
import 'package:honey_mobile/models/api-response.dart';
import 'package:honey_mobile/models/auth/token.dart';

class OtpService {
  final Dio client = Dio(BaseOptions(
    baseUrl: 'https://api.pub.dev',
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 13),
    responseType: ResponseType.json,
  ));
  late String typeOtp;
  late String otpUsecase;

  OtpService(this.typeOtp, this.otpUsecase);

  Future<Response<dynamic>?> sendOtp(
      String phoneNumber, String countryCode) async {
    try {
      final response =
          await client.post("${HttpApiConstant.BASE_URL}/api/otp/send", data: {
        'phone_number': phoneNumber,
        'country_code': countryCode,
        'type_otp': typeOtp,
        'otp_usecase': otpUsecase
      });
      return response;
    } catch (e) {
      print('Error send otp: $e');
      return null;
    }
  }

  Future<Token?> verifyLoginOtp(String phoneNumber, String countryCode,
      String code, List<double> coordinations, String? deviceId) async {
    try {
      String? name = await _getId();
      print({
        'phone_number': phoneNumber,
        'country_code': countryCode,
        'code': code,
        'device_name': name,
        'coordinations': coordinations,
        'device_id': deviceId
      });
      final response =
          await client.put("${HttpApiConstant.BASE_URL}/api/auth/login", data: {
        'phone_number': phoneNumber,
        'country_code': countryCode,
        'code': code,
        'device_name': name,
        'coordinations': coordinations,
        'device_id': deviceId
      });

      ApiResponse parsedResponse =
          ApiResponse<Token>.fromJson(response.data, Token.fromJsonT);
      return parsedResponse.data;
    } on DioException catch (err) {
      final errorMessage = CustomDioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<bool?> verifyRegisterOtp(
      String phoneNumber, String countryCode, String code) async {
    try {
      await client
          .post("${HttpApiConstant.BASE_URL}/api/auth/manual-register", data: {
        'phone_number': phoneNumber,
        'country_code': countryCode,
        'code': code,
      });

      return true;
    } on DioException catch (err) {
      final errorMessage = CustomDioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      print("verifyRegisterOtp");
      print(e);
      throw e.toString();
    }
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.name; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.product; // unique ID on Android
    }
    return null;
  }
}
