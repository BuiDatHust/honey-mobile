// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Friend _$FriendFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      '_id',
      'user',
      'chat_seeting_id',
      'type_matching',
      'status',
      'created_at'
    ],
  );
  return Friend(
    id: json['_id'] as String,
    user: UserPendingReaction.fromJson(json['user'] as Map<String, dynamic>),
    chat_seeting_id: json['chat_seeting_id'] as String,
    type_matching: json['type_matching'] as String,
    is_chatted: json['is_chatted'] as bool?,
    status: json['status'] as String,
    created_at: json['created_at'] as int,
    updated_at: json['updated_at'] as int?,
  );
}

Map<String, dynamic> _$FriendToJson(Friend instance) => <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'chat_seeting_id': instance.chat_seeting_id,
      'type_matching': instance.type_matching,
      'is_chatted': instance.is_chatted,
      'status': instance.status,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
