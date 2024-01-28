// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination-response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationResponse _$PaginationResponseFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['has_more'],
  );
  return PaginationResponse(
    has_more: json['has_more'] as bool,
    next_cursor: json['next_cursor'] as String?,
  );
}

Map<String, dynamic> _$PaginationResponseToJson(PaginationResponse instance) =>
    <String, dynamic>{
      'has_more': instance.has_more,
      'next_cursor': instance.next_cursor,
    };
