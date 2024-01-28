import 'package:dio/dio.dart';
import 'package:honey_mobile/core/constants/http.dart';
import 'package:honey_mobile/core/network/dio-exception.dart';
import 'package:honey_mobile/models/user/media-response.dart';
import 'package:honey_mobile/models/user/media.dart';

class UploadService {
  final Dio client = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 13),
    responseType: ResponseType.json,
  ));

  Future<List<Media>?> uploadMany(List<dynamic> files) async {
    try {
      List<Media> result = [];
      for (int i = 0; i < files.length; i++) {
        var file = files[i];
        if (file == null) {
          result.add(Media(url: ""));
          continue;
        }
        if (file.runtimeType == String) {
          result.add(Media(url: file));
          continue;
        }

        String fileName = file.path.split('/').last;
        String typeUploadFile = _getUploadFileType(fileName);
        MultipartFile fileBody =
            await MultipartFile.fromFile(file.path, filename: fileName);
        FormData formData = FormData.fromMap({
          "files": fileBody,
        });
        final response = await client.post(
            "${HttpApiConstant.BASE_URL}/media-api/upload/$typeUploadFile",
            data: formData);

        MediaResponse parsedResponse = MediaResponse.fromJson(response.data);
        result.add(parsedResponse.data[0]);
      }

      return result;
    } on DioException catch (err) {
      final errorMessage = CustomDioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      print("uploadMany $e");
      throw e.toString();
    }
  }

  _getUploadFileType(String filename) {
    String type = filename.split('.')[1];
    List<String> imageTypes = ['jpeg', 'jpg', 'png'];
    List<String> videoTypes = ['mp4'];
    List<String> audioTypes = ['mp3'];

    if (imageTypes.contains(type)) {
      return 'image';
    }
    if (videoTypes.contains(type)) {
      return 'video';
    }
    if (audioTypes.contains(type)) {
      return 'audio';
    }

    throw Error();
  }
}
