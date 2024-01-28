// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      '_id',
      'sender_user_id',
      'reciever_user_id',
      'content',
      'type_content',
      'type_message',
      'created_at'
    ],
  );
  return Message(
    id: json['_id'] as String,
    sender_user_id: json['sender_user_id'] as String,
    reciever_user_id: json['reciever_user_id'] as String,
    chat_seeting_id: json['chat_seeting_id'] as String?,
    meeting_record_id: json['meeting_record_id'] as String?,
    content: json['content'] as String,
    reaction: json['reaction'] as String?,
    type_content: json['type_content'] as String,
    type_message: json['type_message'] as String,
    created_at: json['created_at'] as int,
    updated_at: json['updated_at'] as int?,
    deleted_at: json['deleted_at'] as int?,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      '_id': instance.id,
      'sender_user_id': instance.sender_user_id,
      'reciever_user_id': instance.reciever_user_id,
      'chat_seeting_id': instance.chat_seeting_id,
      'meeting_record_id': instance.meeting_record_id,
      'content': instance.content,
      'reaction': instance.reaction,
      'type_content': instance.type_content,
      'type_message': instance.type_message,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'deleted_at': instance.deleted_at,
    };
