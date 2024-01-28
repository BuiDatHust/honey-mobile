import 'package:json_annotation/json_annotation.dart';

part 'react-profile-response.g.dart';

@JsonSerializable()
class ReactProfileResponse {
  @JsonKey(required: true)
  bool is_matching;

  @JsonKey(required: false)
  String? chat_setting_id;

  ReactProfileResponse({
    required this.is_matching,
    this.chat_setting_id,
  });
  factory ReactProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ReactProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReactProfileResponseToJson(this);

  static ReactProfileResponse fromJsonT(Object? json) {
    if (json == null) {
      return ReactProfileResponse(is_matching: false);
    }

    return _$ReactProfileResponseFromJson(json as Map<String, dynamic>);
  }
}
