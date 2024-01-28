// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['_id', 'phone_number', 'status', 'created_at'],
  );
  return Profile(
    phone_number: json['phone_number'] as String,
    country_code: json['country_code'] as String,
    status: json['status'] as String,
    id: json['_id'] as String,
    created_at: json['created_at'] as int,
    show_medias: (json['show_medias'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : ShowMedia.fromJson(e as Map<String, dynamic>))
        .toList(),
    firstname: json['firstname'] as String?,
    email: json['email'] as String?,
    medias: (json['medias'] as List<dynamic>?)
        ?.map(
            (e) => e == null ? null : Media.fromJson(e as Map<String, dynamic>))
        .toList(),
    gender: json['gender'] as String?,
    gender_show: json['gender_show'] as String?,
    dob: json['dob'] as int?,
    age: json['age'] as int?,
    height: json['height'] as int?,
    sexual_orientation: json['sexual_orientation'] as String?,
    relationship_goal: json['relationship_goal'] as String?,
    description: json['description'] as String?,
    passions:
        (json['passions'] as List<dynamic>?)?.map((e) => e as String).toList(),
    company: json['company'] as String?,
    job_title: json['job_title'] as String?,
    address: json['address'] as String?,
    languages:
        (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList(),
    coordinates: (json['coordinates'] as List<dynamic>?)
        ?.map((e) => (e as num).toDouble())
        .toList(),
    visualization_fields: (json['visualization_fields'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    is_verified: json['is_verified'] as bool?,
    is_verified_phone: json['is_verified_phone'] as bool?,
    is_verified_email: json['is_verified_email'] as bool?,
    updated_at: json['updated_at'] as int?,
    deleted_at: json['deleted_at'] as int?,
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      '_id': instance.id,
      'firstname': instance.firstname,
      'phone_number': instance.phone_number,
      'email': instance.email,
      'medias': instance.medias,
      'show_medias': instance.show_medias,
      'gender': instance.gender,
      'gender_show': instance.gender_show,
      'dob': instance.dob,
      'age': instance.age,
      'height': instance.height,
      'sexual_orientation': instance.sexual_orientation,
      'relationship_goal': instance.relationship_goal,
      'description': instance.description,
      'country_code': instance.country_code,
      'passions': instance.passions,
      'company': instance.company,
      'job_title': instance.job_title,
      'address': instance.address,
      'languages': instance.languages,
      'coordinates': instance.coordinates,
      'visualization_fields': instance.visualization_fields,
      'is_verified': instance.is_verified,
      'status': instance.status,
      'is_verified_phone': instance.is_verified_phone,
      'is_verified_email': instance.is_verified_email,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'deleted_at': instance.deleted_at,
    };
