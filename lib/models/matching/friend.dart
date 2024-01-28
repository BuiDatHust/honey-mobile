import 'package:honey_mobile/models/matching/user-pending-reaction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'friend.g.dart';

@JsonSerializable()
class Friend {
  @JsonKey(required: true, name: "_id")
  String id;

  @JsonKey(required: true)
  UserPendingReaction user;

  @JsonKey(required: true)
  String chat_seeting_id;

  @JsonKey(required: true)
  String type_matching;

  @JsonKey(required: false)
  bool? is_chatted;

  @JsonKey(required: true)
  String status;

  @JsonKey(required: true)
  int created_at;

  @JsonKey(required: false)
  int? updated_at;

  Friend(
      {required this.id,
      required this.user,
      required this.chat_seeting_id,
      required this.type_matching,
      this.is_chatted,
      required this.status,
      required this.created_at,
      this.updated_at});

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);
  Map<String, dynamic> toJson() => _$FriendToJson(this);

  static Friend fromJsonT(Object? json) {
    if (json == null) {
      return Friend(
          id: "",
          chat_seeting_id: "",
          status: "",
          type_matching: "",
          user: UserPendingReaction(id: "", firstname: "", show_medias: []),
          created_at: 10000);
    }

    return _$FriendFromJson(json as Map<String, dynamic>);
  }
}
