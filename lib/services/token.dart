import 'package:dio/dio.dart';
import 'package:honey_mobile/core/constants/http.dart';
import 'package:honey_mobile/core/constants/token.dart';
import 'package:honey_mobile/core/network/dio-exception.dart';
import 'package:honey_mobile/models/api-response.dart';
import 'package:honey_mobile/models/auth/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  final Dio client = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 13),
    responseType: ResponseType.json,
  ));

  Future<void> deleteTokenInLocal() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await Future.wait([
        prefs.remove(ACCESS_TOKEN_KEY),
        prefs.remove(REFRESH_TOKEN_KEY),
      ]);
    } catch (e) {
      print("error to delete token: $e");
    }
  }

  Future<Token?> getNewToken(String refreshToken) async {
    try {
      final response = await client.get(
          "${HttpApiConstant.BASE_URL}/api/user/personal-info",
          data: {"refresh_token": refreshToken});

      ApiResponse parsedResponse =
          ApiResponse<Token>.fromJson(response.data, Token.fromJsonT);
      Token? token = parsedResponse.data;
      if (token != null) {
        await saveTokenToLocalDevice(token);
      }
      return token;
    } on DioException catch (err) {
      final errorMessage = CustomDioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<Token> getToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString(ACCESS_TOKEN_KEY) ?? "";
      String refreshToken = prefs.getString(REFRESH_TOKEN_KEY) ?? "";
      String deviceId = prefs.getString(DEVICE_ID_KEY) ?? "";
      Token token = Token(
          access_token: accessToken,
          refresh_token: refreshToken,
          device_id: deviceId);
      return token;
    } catch (e) {
      print("error to save token: $e");
      return const Token(access_token: "", refresh_token: "", device_id: "");
    }
  }

  Future<void> saveTokenToLocalDevice(Token token) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await Future.wait([
        prefs.setString(ACCESS_TOKEN_KEY, token.access_token),
        prefs.setString(REFRESH_TOKEN_KEY, token.refresh_token),
        prefs.setString(DEVICE_ID_KEY, token.device_id)
      ]);
    } catch (e) {
      print("error to save token: $e");
    }
  }
}
