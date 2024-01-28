// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media-response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaResponse _$MediaResponseFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['message', 'statusCode'],
  );
  return MediaResponse(
    message: json['message'] as String,
    error: json['error'] as String?,
    status_code: json['statusCode'] as int,
    data: (json['data'] as List<dynamic>)
        .map((e) => Media.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MediaResponseToJson(MediaResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'error': instance.error,
      'statusCode': instance.status_code,
      'data': instance.data,
    };
