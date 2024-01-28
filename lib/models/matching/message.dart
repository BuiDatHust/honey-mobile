import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  @JsonKey(required: true, name: "_id")
  String id;

  @JsonKey(required: true)
  String sender_user_id;

  @JsonKey(required: true)
  String reciever_user_id;

  @JsonKey(required: false)
  String? chat_seeting_id;

  @JsonKey(required: false)
  String? meeting_record_id;

  @JsonKey(required: true)
  String content;

  @JsonKey(required: false)
  String? reaction;

  @JsonKey(required: true)
  String type_content;

  @JsonKey(required: true)
  String type_message;

  @JsonKey(required: true)
  int created_at;

  @JsonKey(required: false)
  int? updated_at;

  @JsonKey(required: false)
  int? deleted_at;

  Message(
      {required this.id,
      required this.sender_user_id,
      required this.reciever_user_id,
      this.chat_seeting_id,
      this.meeting_record_id,
      required this.content,
      this.reaction,
      required this.type_content,
      required this.type_message,
      required this.created_at,
      this.updated_at,
      this.deleted_at});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  static Message fromJsonT(Object? json) {
    if (json == null) {
      return Message(
          id: "",
          sender_user_id: "",
          reciever_user_id: "",
          content: "",
          type_content: "",
          type_message: "",
          created_at: 1111);
    }

    return _$MessageFromJson(json as Map<String, dynamic>);
  }
}
