// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      '_id',
      'first_user_id',
      'second_user_id',
      'user',
      'last_send_message_at',
      'last_message_id',
      'created_at'
    ],
  );
  return Chat(
    id: json['_id'] as String,
    first_user: UserPendingReaction.fromJson(
        json['first_user_id'] as Map<String, dynamic>),
    second_user: UserPendingReaction.fromJson(
        json['second_user_id'] as Map<String, dynamic>),
    last_send_message_at: json['last_send_message_at'] as int,
    last_message:
        Message.fromJson(json['last_message_id'] as Map<String, dynamic>),
    created_at: json['created_at'] as int,
    user: UserPendingReaction.fromJson(json['user'] as Map<String, dynamic>),
    updated_at: json['updated_at'] as int?,
  );
}

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      '_id': instance.id,
      'first_user_id': instance.first_user,
      'second_user_id': instance.second_user,
      'user': instance.user,
      'last_send_message_at': instance.last_send_message_at,
      'last_message_id': instance.last_message,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
