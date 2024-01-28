// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['access_token', 'refresh_token', 'device_id'],
  );
  return Token(
    access_token: json['access_token'] as String,
    refresh_token: json['refresh_token'] as String,
    device_id: json['device_id'] as String,
  );
}

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'access_token': instance.access_token,
      'refresh_token': instance.refresh_token,
      'device_id': instance.device_id,
    };
