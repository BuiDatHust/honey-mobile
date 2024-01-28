import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api-response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> extends Equatable {
  @JsonKey(required: true)
  final String message;
  @JsonKey()
  final String? error;
  @JsonKey(required: true, name: 'statusCode')
  final int status_code;
  @JsonKey(required: false)
  final T? data;

  const ApiResponse(
      {required this.message,
      this.error,
      required this.status_code,
      this.data});

  factory ApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ApiResponseFromJson<T>(json, fromJsonT);
  @override
  List<Object?> get props => [message, error, status_code, data];

  Map<String, dynamic> toJson() =>
      _$ApiResponseToJson(this, T as T Function(Object? json));
}
