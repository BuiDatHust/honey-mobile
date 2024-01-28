import 'package:json_annotation/json_annotation.dart';

part 'search-setting.g.dart';

@JsonSerializable()
class SearchSetting {
  @JsonKey(required: true, name: "_id")
  String id;

  @JsonKey(required: true)
  String user_id;

  @JsonKey(required: false)
  int? distance_preference;

  @JsonKey(required: false)
  String? unit_distance;

  @JsonKey(required: false)
  bool? is_only_show_in_distance;

  @JsonKey(required: false)
  int? min_age_preference;

  @JsonKey(required: false)
  int? max_age_preference;

  @JsonKey(required: false)
  bool? is_only_show_in_age;

  @JsonKey(required: true)
  int created_at;

  @JsonKey(required: false)
  int? updated_at;

  SearchSetting(
      {required this.id,
      required this.user_id,
      required this.created_at,
      this.distance_preference,
      this.unit_distance,
      this.is_only_show_in_distance,
      this.is_only_show_in_age,
      this.min_age_preference,
      this.max_age_preference,
      this.updated_at});

      factory SearchSetting.fromJson(Map<String, dynamic> json) =>
      _$SearchSettingFromJson(json);
  Map<String, dynamic> toJson() => _$SearchSettingToJson(this);
}
