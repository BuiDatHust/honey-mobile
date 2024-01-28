import 'package:honey_mobile/models/pagination-response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api-cursor-paginate-response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiCursorPaginateResponse<T> {
  @JsonKey(required: true)
  final String message;
  @JsonKey(required: false)
  final String? error;
  @JsonKey(required: true, name: 'statusCode')
  final int status_code;
  @JsonKey(required: true)
  final List<T> data;
  @JsonKey(required: true)
  final PaginationResponse pagination;

  const ApiCursorPaginateResponse(
      {required this.message,
      this.error,
      required this.status_code,
      required this.data,
      required this.pagination});

  factory ApiCursorPaginateResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ApiCursorPaginateResponseFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson() =>
      _$ApiCursorPaginateResponseToJson(this, T as T Function(Object? json));
}
