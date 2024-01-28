// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email-setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailSetting _$EmailSettingFromJson(Map<String, dynamic> json) => EmailSetting(
      is_send_new_match: json['is_send_new_match'] as bool?,
      is_send_new_message: json['is_send_new_message'] as bool?,
    );

Map<String, dynamic> _$EmailSettingToJson(EmailSetting instance) =>
    <String, dynamic>{
      'is_send_new_match': instance.is_send_new_match,
      'is_send_new_message': instance.is_send_new_message,
    };
