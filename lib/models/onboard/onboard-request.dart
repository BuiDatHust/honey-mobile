import 'package:json_annotation/json_annotation.dart';

part 'onboard-request.g.dart';

@JsonSerializable()
class OnboardRequest {
  @JsonKey(required: true)
  String first_name;

  @JsonKey(required: true)
  int dob;

  @JsonKey(required: true)
  String gender;

  @JsonKey(required: true)
  List<String> passions;

  @JsonKey(required: true)
  String sexual_orientation;

  @JsonKey(required: true)
  List<String> medias;

  @JsonKey(required: true)
  List<String> visualization_fields;

  OnboardRequest(
      {required this.first_name,
      required this.dob,
      required this.gender,
      required this.passions,
      required this.sexual_orientation,
      required this.medias,
      required this.visualization_fields});

  factory OnboardRequest.fromJson(Map<String, dynamic> json) =>
      _$OnboardRequestFromJson(json);
  Map<String, dynamic> toJson() => _$OnboardRequestToJson(this);
}
