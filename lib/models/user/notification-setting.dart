import 'package:honey_mobile/models/user/email-setting.dart';
import 'package:honey_mobile/models/user/push-notification.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification-setting.g.dart';

@JsonSerializable()
class NotificationSetting {
  @JsonKey(required: true, name: "_id")
  String id;

  @JsonKey(required: true)
  String user_id;

  @JsonKey(required: true)
  EmailSetting email_setting;

  @JsonKey(required: true)
  PushNotificationSetting push_notification_setting;

  @JsonKey(required: true)
  int created_at;

  @JsonKey(required: false)
  int? updated_at;

  NotificationSetting(
      {required this.id,
      required this.user_id,
      required this.created_at,
      required this.email_setting,
      required this.push_notification_setting,
      this.updated_at});
      
      factory NotificationSetting.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationSettingToJson(this);
}
