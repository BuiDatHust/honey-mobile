import 'package:json_annotation/json_annotation.dart';

part 'email-setting.g.dart';

@JsonSerializable()
class EmailSetting {
  @JsonKey(required: false)
  bool? is_send_new_match;

  @JsonKey(required: false)
  bool? is_send_new_message;

  EmailSetting({this.is_send_new_match, this.is_send_new_message});

  factory EmailSetting.fromJson(Map<String, dynamic> json) =>
      _$EmailSettingFromJson(json);
  Map<String, dynamic> toJson() => _$EmailSettingToJson(this);
}
