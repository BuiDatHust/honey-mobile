// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboard-request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnboardRequest _$OnboardRequestFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'first_name',
      'dob',
      'gender',
      'passions',
      'sexual_orientation',
      'medias',
      'visualization_fields'
    ],
  );
  return OnboardRequest(
    first_name: json['first_name'] as String,
    dob: json['dob'] as int,
    gender: json['gender'] as String,
    passions:
        (json['passions'] as List<dynamic>).map((e) => e as String).toList(),
    sexual_orientation: json['sexual_orientation'] as String,
    medias: (json['medias'] as List<dynamic>).map((e) => e as String).toList(),
    visualization_fields: (json['visualization_fields'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$OnboardRequestToJson(OnboardRequest instance) =>
    <String, dynamic>{
      'first_name': instance.first_name,
      'dob': instance.dob,
      'gender': instance.gender,
      'passions': instance.passions,
      'sexual_orientation': instance.sexual_orientation,
      'medias': instance.medias,
      'visualization_fields': instance.visualization_fields,
    };
