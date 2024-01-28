// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user-pending-reaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPendingReaction _$UserPendingReactionFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['_id', 'firstname', 'show_medias'],
  );
  return UserPendingReaction(
    id: json['_id'] as String,
    firstname: json['firstname'] as String,
    show_medias: (json['show_medias'] as List<dynamic>)
        .map((e) => ShowMedia.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UserPendingReactionToJson(
        UserPendingReaction instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'firstname': instance.firstname,
      'show_medias': instance.show_medias,
    };
