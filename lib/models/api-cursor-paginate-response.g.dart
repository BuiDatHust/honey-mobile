// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api-cursor-paginate-response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiCursorPaginateResponse<T> _$ApiCursorPaginateResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  $checkKeys(
    json,
    requiredKeys: const ['message', 'statusCode', 'data', 'pagination'],
  );
  return ApiCursorPaginateResponse<T>(
    message: json['message'] as String,
    error: json['error'] as String?,
    status_code: json['statusCode'] as int,
    data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
    pagination:
        PaginationResponse.fromJson(json['pagination'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ApiCursorPaginateResponseToJson<T>(
  ApiCursorPaginateResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'message': instance.message,
      'error': instance.error,
      'statusCode': instance.status_code,
      'data': instance.data.map(toJsonT).toList(),
      'pagination': instance.pagination,
    };
