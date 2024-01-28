import 'package:json_annotation/json_annotation.dart';

part 'push-notification.g.dart';

@JsonSerializable()
class PushNotificationSetting {
  @JsonKey(required: false)
  bool? is_send_new_match;

  @JsonKey(required: false)
  bool? is_send_new_message;

  @JsonKey(required: false)
  bool? is_send_message_like;

  PushNotificationSetting(
      {this.is_send_new_match,
      this.is_send_new_message,
      this.is_send_message_like});

      factory PushNotificationSetting.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationSettingFromJson(json);
  Map<String, dynamic> toJson() => _$PushNotificationSettingToJson(this);
}
