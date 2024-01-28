// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account-setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountSetting _$AccountSettingFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['_id', 'user_id', 'created_at'],
  );
  return AccountSetting(
    id: json['_id'] as String,
    user_id: json['user_id'] as String,
    created_at: json['created_at'] as int,
    language: json['language'] as String?,
    unit_distance: json['unit_distance'] as String?,
    updated_at: json['updated_at'] as int?,
  );
}

Map<String, dynamic> _$AccountSettingToJson(AccountSetting instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.user_id,
      'language': instance.language,
      'unit_distance': instance.unit_distance,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
