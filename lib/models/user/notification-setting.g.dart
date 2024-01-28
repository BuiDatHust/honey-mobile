// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification-setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationSetting _$NotificationSettingFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      '_id',
      'user_id',
      'email_setting',
      'push_notification_setting',
      'created_at'
    ],
  );
  return NotificationSetting(
    id: json['_id'] as String,
    user_id: json['user_id'] as String,
    created_at: json['created_at'] as int,
    email_setting:
        EmailSetting.fromJson(json['email_setting'] as Map<String, dynamic>),
    push_notification_setting: PushNotificationSetting.fromJson(
        json['push_notification_setting'] as Map<String, dynamic>),
    updated_at: json['updated_at'] as int?,
  );
}

Map<String, dynamic> _$NotificationSettingToJson(
        NotificationSetting instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.user_id,
      'email_setting': instance.email_setting,
      'push_notification_setting': instance.push_notification_setting,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
