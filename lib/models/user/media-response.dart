import 'package:honey_mobile/models/user/media.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media-response.g.dart';

@JsonSerializable()
class MediaResponse {
  @JsonKey(required: true)
  final String message;

  @JsonKey()
  final String? error;

  @JsonKey(required: true, name: 'statusCode')
  final int status_code;

  @JsonKey(required: false)
  final List<Media> data;

  const MediaResponse(
      {required this.message,
      this.error,
      required this.status_code,
      required this.data});

  factory MediaResponse.fromJson(Map<String, dynamic> json) =>
      _$MediaResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MediaResponseToJson(this);
}
