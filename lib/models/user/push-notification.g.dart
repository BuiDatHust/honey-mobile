// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push-notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushNotificationSetting _$PushNotificationSettingFromJson(
        Map<String, dynamic> json) =>
    PushNotificationSetting(
      is_send_new_match: json['is_send_new_match'] as bool?,
      is_send_new_message: json['is_send_new_message'] as bool?,
      is_send_message_like: json['is_send_message_like'] as bool?,
    );

Map<String, dynamic> _$PushNotificationSettingToJson(
        PushNotificationSetting instance) =>
    <String, dynamic>{
      'is_send_new_match': instance.is_send_new_match,
      'is_send_new_message': instance.is_send_new_message,
      'is_send_message_like': instance.is_send_message_like,
    };
