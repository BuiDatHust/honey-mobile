// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search-setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSetting _$SearchSettingFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['_id', 'user_id', 'created_at'],
  );
  return SearchSetting(
    id: json['_id'] as String,
    user_id: json['user_id'] as String,
    created_at: json['created_at'] as int,
    distance_preference: json['distance_preference'] as int?,
    unit_distance: json['unit_distance'] as String?,
    is_only_show_in_distance: json['is_only_show_in_distance'] as bool?,
    is_only_show_in_age: json['is_only_show_in_age'] as bool?,
    min_age_preference: json['min_age_preference'] as int?,
    max_age_preference: json['max_age_preference'] as int?,
    updated_at: json['updated_at'] as int?,
  );
}

Map<String, dynamic> _$SearchSettingToJson(SearchSetting instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.user_id,
      'distance_preference': instance.distance_preference,
      'unit_distance': instance.unit_distance,
      'is_only_show_in_distance': instance.is_only_show_in_distance,
      'min_age_preference': instance.min_age_preference,
      'max_age_preference': instance.max_age_preference,
      'is_only_show_in_age': instance.is_only_show_in_age,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
