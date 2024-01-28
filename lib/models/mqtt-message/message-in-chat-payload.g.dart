// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message-in-chat-payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageInChatPayload _$MessageInChatPayloadFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'user_id',
      'chat_id',
      'content',
      'type_content',
      'type_message',
      'access_token'
    ],
  );
  return MessageInChatPayload(
    user_id: json['user_id'] as String,
    chat_id: json['chat_id'] as String,
    content: json['content'] as String,
    type_content: json['type_content'] as String,
    type_message: json['type_message'] as String,
    access_token: json['access_token'] as String,
  );
}

Map<String, dynamic> _$MessageInChatPayloadToJson(
        MessageInChatPayload instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'chat_id': instance.chat_id,
      'content': instance.content,
      'type_content': instance.type_content,
      'type_message': instance.type_message,
      'access_token': instance.access_token,
    };
