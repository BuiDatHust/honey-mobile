import 'package:json_annotation/json_annotation.dart';

part 'show-media.g.dart';

@JsonSerializable()
class ShowMedia {
  @JsonKey(required: true)
  String url;

  @JsonKey(required: false)
  int? width;

  @JsonKey(required: false)
  int? height;

  ShowMedia({
    required this.url,
    this.width,
    this.height,
  });

  factory ShowMedia.fromJson(Map<String, dynamic> json) =>
      _$ShowMediaFromJson(json);  
  Map<String, dynamic> toJson() => _$ShowMediaToJson(this);
}
