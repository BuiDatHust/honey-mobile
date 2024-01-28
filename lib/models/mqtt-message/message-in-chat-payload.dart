import 'package:json_annotation/json_annotation.dart';

part 'message-in-chat-payload.g.dart';

@JsonSerializable()
class MessageInChatPayload {
  @JsonKey(required: true)
  String user_id;

  @JsonKey(required: true)
  String chat_id;

  @JsonKey(required: true)
  String content;

  @JsonKey(required: true)
  String type_content;

  @JsonKey(required: true)
  String type_message;

  @JsonKey(required: true)
  String access_token;

  MessageInChatPayload({
    required this.user_id,
    required this.chat_id,
    required this.content,
    required this.type_content,
    required this.type_message,
    required this.access_token,
  });

  factory MessageInChatPayload.fromJson(Map<String, dynamic> json) =>
      _$MessageInChatPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$MessageInChatPayloadToJson(this);
}
