import 'package:json_annotation/json_annotation.dart';

part 'pagination-response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginationResponse {
  @JsonKey(required: true)
  final bool has_more;
  
  @JsonKey(required: false)
  final String? next_cursor;

  const PaginationResponse({required this.has_more, this.next_cursor});

  factory PaginationResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationResponseToJson(this);
}
