import 'package:dio/dio.dart';
import 'package:honey_mobile/core/constants/http.dart';
import 'package:honey_mobile/core/network/dio-exception.dart';
import 'package:honey_mobile/models/api-cursor-paginate-response.dart';
import 'package:honey_mobile/models/matching/friend.dart';
import 'package:honey_mobile/models/matching/pending-reaction.dart';

class FriendService {
  final Dio client = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 13),
    responseType: ResponseType.json,
  ));

  Future<ApiCursorPaginateResponse<Friend>> getAllFriend(String accessToken,
      bool isGetRecentlyMatch, int limit, String? cursor) async {
    String queryString =
        "?is_get_recently_match=$isGetRecentlyMatch&limit=$limit";
    if (cursor != null) {
      queryString += "&cursor=$cursor";
    }

    try {
      final response = await client.get(
          "${HttpApiConstant.BASE_URL}/api/friend/list$queryString",
          options: Options(headers: {"Authorization": "Bearer $accessToken"}));

      ApiCursorPaginateResponse<Friend> parsedResponse =
          ApiCursorPaginateResponse<Friend>.fromJson(
              response.data, Friend.fromJsonT);
      return parsedResponse;
    } on DioException catch (err) {
      final errorMessage = CustomDioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<ApiCursorPaginateResponse<PendingReaction>> getPendingReaction(
      String accessToken,
      String? cursor,
      int? limit,
      String typePendingReaction) async {
    String queryString = "?type_pending=$typePendingReaction";
    if (limit != null) {
      queryString += "&limit=$limit";
    }
    if (cursor != null) {
      queryString += "&cursor=$cursor";
    }

    try {
      final response = await client.get(
          "${HttpApiConstant.BASE_URL}/api/friend/pending-reaction$queryString",
          options: Options(headers: {"Authorization": "Bearer $accessToken"}));

      print(response);

      ApiCursorPaginateResponse<PendingReaction> parsedResponse =
          ApiCursorPaginateResponse<PendingReaction>.fromJson(
              response.data, PendingReaction.fromJsonT);
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
