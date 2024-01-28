import 'package:dio/dio.dart';
import 'package:honey_mobile/core/constants/http.dart';
import 'package:honey_mobile/core/network/dio-exception.dart';
import 'package:honey_mobile/models/api-cursor-paginate-response.dart';
import 'package:honey_mobile/models/api-response.dart';
import 'package:honey_mobile/models/profile/profile.dart';
import 'package:honey_mobile/models/profile/react-profile-response.dart';

class ProfileService {
  final Dio client = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 13),
    responseType: ResponseType.json,
  ));

  Future<ApiCursorPaginateResponse<Profile>> getRecommendProfile(
      String accessToken,
      bool isGetRecentlyMatch,
      int limit,
      String? cursor) async {
    String queryString = "?limit=$limit";
    if (cursor != null) {
      queryString += "&cursor=$cursor";
    }

    try {
      final response = await client.get(
          "${HttpApiConstant.BASE_URL}/api/profile/list$queryString",
          options: Options(headers: {"Authorization": "Bearer $accessToken"}));
      print(response);
      ApiCursorPaginateResponse<Profile> parsedResponse =
          ApiCursorPaginateResponse<Profile>.fromJson(
              response.data, Profile.fromJsonT);
      return parsedResponse;
    } on DioException catch (err) {
      final errorMessage = CustomDioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<ApiResponse<ReactProfileResponse>> reactProfile(String accessToken,
      String typeMatching, String userId, String typeReaction) async {
    try {
      final response = await client.put(
          "${HttpApiConstant.BASE_URL}/api/profile/reaction",
          data: {
            "type_matching": typeMatching,
            "user_id": userId,
            "type_reaction": typeReaction
          },
          options: Options(headers: {"Authorization": "Bearer $accessToken"}));
      print(response);
      ApiResponse<ReactProfileResponse> parsedResponse =
          ApiResponse<ReactProfileResponse>.fromJson(
              response.data, ReactProfileResponse.fromJsonT);
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
