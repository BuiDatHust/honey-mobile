// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'react-profile-response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReactProfileResponse _$ReactProfileResponseFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['is_matching'],
  );
  return ReactProfileResponse(
    is_matching: json['is_matching'] as bool,
    chat_setting_id: json['chat_setting_id'] as String?,
  );
}

Map<String, dynamic> _$ReactProfileResponseToJson(
        ReactProfileResponse instance) =>
    <String, dynamic>{
      'is_matching': instance.is_matching,
      'chat_setting_id': instance.chat_setting_id,
    };
