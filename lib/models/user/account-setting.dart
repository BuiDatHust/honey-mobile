import 'package:json_annotation/json_annotation.dart';

part 'account-setting.g.dart';

@JsonSerializable()
class AccountSetting {
  @JsonKey(required: true, name: "_id")
  String id;

  @JsonKey(required: true)
  String user_id;

  @JsonKey(required: false)
  String? language;

  @JsonKey(required: false)
  String? unit_distance;

  @JsonKey(required: true)
  int created_at;

  @JsonKey(required: false)
  int? updated_at;

  AccountSetting(
      {required this.id,
      required this.user_id,
      required this.created_at,
      this.language,
      this.unit_distance,
      required this.updated_at});

  factory AccountSetting.fromJson(Map<String, dynamic> json) =>
      _$AccountSettingFromJson(json);
  Map<String, dynamic> toJson() => _$AccountSettingToJson(this);
}
