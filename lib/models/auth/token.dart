import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token extends Equatable {
  @JsonKey(required: true)
  final String access_token;
  @JsonKey(required: true)
  final String refresh_token;
  @JsonKey(required: true)
  final String device_id;

  const Token(
      {required this.access_token,
      required this.refresh_token,
      required this.device_id});

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
  @override
  List<Object?> get props => [access_token, refresh_token, device_id];
  Map<String, dynamic> toJson() => _$TokenToJson(this);

  static Token fromJsonT(Object? json) {
    if (json == null) {
      return const Token(access_token: "", refresh_token: "", device_id: "");
    }

    return _$TokenFromJson(json as Map<String, dynamic>);
  }
}
