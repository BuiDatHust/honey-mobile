// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending-reaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingReaction _$PendingReactionFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      '_id',
      'user',
      'type_matching',
      'type_reaction',
      'created_at'
    ],
  );
  return PendingReaction(
    id: json['_id'] as String,
    user: UserPendingReaction.fromJson(json['user'] as Map<String, dynamic>),
    is_pending: json['is_pending'] as bool,
    type_reaction: json['type_reaction'] as String,
    type_matching: json['type_matching'] as String,
    created_at: json['created_at'] as int,
    updated_at: json['updated_at'] as int?,
  );
}

Map<String, dynamic> _$PendingReactionToJson(PendingReaction instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'type_matching': instance.type_matching,
      'type_reaction': instance.type_reaction,
      'is_pending': instance.is_pending,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
