import 'package:dio/dio.dart';
import 'package:honey_mobile/core/constants/http.dart';
import 'package:honey_mobile/core/network/dio-exception.dart';
import 'package:honey_mobile/models/api-cursor-paginate-response.dart';
import 'package:honey_mobile/models/matching/message.dart';

class MessageService {
  final Dio client = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 13),
    responseType: ResponseType.json,
  ));

  Future<ApiCursorPaginateResponse<Message>> getListMessage(
      String accessToken, int limit, String chatId, String? cursor) async {
    String queryString = "?limit=$limit";
    if (cursor != null) {
      queryString += "&cursor=$cursor";
    }

    try {
      final response = await client.get(
          "${HttpApiConstant.BASE_URL}/api/message/list-in-chat/$chatId$queryString",
          options: Options(headers: {"Authorization": "Bearer $accessToken"}));

      ApiCursorPaginateResponse<Message> parsedResponse =
          ApiCursorPaginateResponse<Message>.fromJson(
              response.data, Message.fromJsonT);
      return parsedResponse;
    } on DioException catch (err) {
      final errorMessage = CustomDioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }
}
