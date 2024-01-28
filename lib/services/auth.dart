import 'package:dio/dio.dart';
import 'package:honey_mobile/core/constants/http.dart';
import 'package:honey_mobile/core/network/dio-exception.dart';

class AuthService {
  final Dio client = Dio(BaseOptions(
    baseUrl: 'https://api.pub.dev',
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 13),
    responseType: ResponseType.json,
  ));

  logout(String accessToken, String logoutType) async {
    try {
      final response = await client.put(
          "${HttpApiConstant.BASE_URL}/api/auth/logout",
          options: Options(headers: {"Authorization": "Bearer $accessToken"}),
          data: {'logout_type': logoutType});
      print(response);
    } on DioException catch (err) {
      final errorMessage = CustomDioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }
}
