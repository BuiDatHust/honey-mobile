import 'package:json_annotation/json_annotation.dart';

part 'media.g.dart';

@JsonSerializable()
class Media {
  @JsonKey(required: false)
  String? url;

  @JsonKey(required: false)
  int? width;

  @JsonKey(required: false)
  int? height;

  Media({
    this.url,
    this.width,
    this.height,
  });

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
  Map<String, dynamic> toJson() => _$MediaToJson(this);
}
