import 'package:honey_mobile/models/matching/message.dart';
import 'package:honey_mobile/models/matching/user-pending-reaction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  @JsonKey(required: true, name: "_id")
  String id;

  @JsonKey(required: true, name: 'first_user_id')
  UserPendingReaction first_user;

  @JsonKey(required: true, name: 'second_user_id')
  UserPendingReaction second_user;

  @JsonKey(required: true)
  UserPendingReaction user;

  @JsonKey(required: true)
  int last_send_message_at;

  @JsonKey(required: true, name: 'last_message_id')
  Message last_message;

  @JsonKey(required: true)
  int created_at;

  @JsonKey(required: false)
  int? updated_at;

  Chat(
      {required this.id,
      required this.first_user,
      required this.second_user,
      required this.last_send_message_at,
      required this.last_message,
      required this.created_at,
      required this.user,
      this.updated_at});

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);

  static Chat fromJsonT(Object? json) {
    if (json == null) {
      return Chat(
          id: "",
          first_user:
              UserPendingReaction(id: "", firstname: "", show_medias: []),
          second_user:
              UserPendingReaction(id: "", firstname: "", show_medias: []),
          user: UserPendingReaction(id: "", firstname: "", show_medias: []),
          last_send_message_at: 1000,
          last_message: Message(
              id: "",
              sender_user_id: "",
              reciever_user_id: "",
              content: "content",
              type_content: "type_content",
              type_message: "type_message",
              created_at: 111),
          created_at: 10000);
    }

    return _$ChatFromJson(json as Map<String, dynamic>);
  }
}
