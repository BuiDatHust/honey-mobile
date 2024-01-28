// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show-media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowMedia _$ShowMediaFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['url'],
  );
  return ShowMedia(
    url: json['url'] as String,
    width: json['width'] as int?,
    height: json['height'] as int?,
  );
}

Map<String, dynamic> _$ShowMediaToJson(ShowMedia instance) => <String, dynamic>{
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
    };
