import 'package:dio/dio.dart';
import 'package:honey_mobile/core/constants/http.dart';
import 'package:honey_mobile/core/network/dio-exception.dart';
import 'package:honey_mobile/models/api-response.dart';
import 'package:honey_mobile/models/user/users.dart';

class UserService {
  final Dio client = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    responseType: ResponseType.json,
  ));

  Future<User?> getPersonalUserInfo(String accessToken) async {
    try {
      final response = await client.get(
          "${HttpApiConstant.BASE_URL}/api/user/personal-info",
          options: Options(headers: {"Authorization": "Bearer $accessToken"}));
      print(response);

      ApiResponse parsedResponse =
          ApiResponse<User>.fromJson(response.data, User.fromJsonT);
      return parsedResponse.data;
    } on DioException catch (err) {
      final errorMessage = CustomDioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<void> onboard(String accessToken, dynamic body) async {
    try {
      await client.post("${HttpApiConstant.BASE_URL}/api/user/onboard",
          options: Options(headers: {"Authorization": "Bearer $accessToken"}),
          data: body);
    } on DioException catch (err) {
      print(err.message);
      final errorMessage = CustomDioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateProfile(String accessToken, dynamic body) async {
    try {
      await client.put("${HttpApiConstant.BASE_URL}/api/profile",
          options: Options(headers: {"Authorization": "Bearer $accessToken"}),
          data: body);
    } on DioException catch (err) {
      print(err.message);
      final errorMessage = CustomDioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateSetting(String accessToken, dynamic body) async {
    try {
      await client.put("${HttpApiConstant.BASE_URL}/api/user/user-setting",
          options: Options(headers: {"Authorization": "Bearer $accessToken"}),
          data: body);
    } on DioException catch (err) {
      print(err.message);
      final errorMessage = CustomDioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }
}
