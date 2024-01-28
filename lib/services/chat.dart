import 'package:dio/dio.dart';
import 'package:honey_mobile/core/constants/http.dart';
import 'package:honey_mobile/core/network/dio-exception.dart';
import 'package:honey_mobile/models/api-cursor-paginate-response.dart';
import 'package:honey_mobile/models/api-response.dart';
import 'package:honey_mobile/models/matching/chat.dart';

class ChatService {
  final Dio client = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 13),
    responseType: ResponseType.json,
  ));

  Future<ApiCursorPaginateResponse<Chat>> getChatList(
      String accessToken, int limit, String? cursor) async {
    String queryString = "?limit=$limit";
    if (cursor != null) {
      queryString += "&cursor=$cursor";
    }

    try {
      final response = await client.get(
          "${HttpApiConstant.BASE_URL}/api/chat/list$queryString",
          options: Options(headers: {"Authorization": "Bearer $accessToken"}));

      ApiCursorPaginateResponse<Chat> parsedResponse =
          ApiCursorPaginateResponse<Chat>.fromJson(
              response.data, Chat.fromJsonT);
      return parsedResponse;
    } on DioException catch (err) {
      final errorMessage = CustomDioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<Chat?> getDetailChat(String accessToken, String chatId) async {
    try {
      final response = await client.get(
          "${HttpApiConstant.BASE_URL}/api/chat/$chatId",
          options: Options(headers: {"Authorization": "Bearer $accessToken"}));

      ApiResponse<Chat> parsedResponse =
          ApiResponse<Chat>.fromJson(response.data, Chat.fromJsonT);
      return parsedResponse.data;
    } on DioException catch (err) {
      final errorMessage = CustomDioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }
}
