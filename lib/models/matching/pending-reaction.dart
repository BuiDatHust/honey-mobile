import 'package:honey_mobile/models/matching/user-pending-reaction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pending-reaction.g.dart';

@JsonSerializable()
class PendingReaction {
  @JsonKey(required: true, name: "_id")
  String id;

  @JsonKey(required: true)
  UserPendingReaction user;

  @JsonKey(required: true)
  String type_matching;

  @JsonKey(required: true)
  String type_reaction;

  @JsonKey(required: false)
  bool is_pending;

  @JsonKey(required: true)
  int created_at;

  @JsonKey(required: false)
  int? updated_at;

  PendingReaction(
      {required this.id,
      required this.user,
      required this.is_pending,
      required this.type_reaction,
      required this.type_matching,
      required this.created_at,
      this.updated_at});

  factory PendingReaction.fromJson(Map<String, dynamic> json) =>
      _$PendingReactionFromJson(json);
  Map<String, dynamic> toJson() => _$PendingReactionToJson(this);

  static PendingReaction fromJsonT(Object? json) {
    if (json == null) {
      return PendingReaction(
          id: "",
          is_pending: false,
          type_reaction: "cc",
          type_matching: "vcdfvf vfvf fvfv",
          user: UserPendingReaction(id: "", firstname: "", show_medias: []),
          created_at: 10000);
    }

    return _$PendingReactionFromJson(json as Map<String, dynamic>);
  }
}
