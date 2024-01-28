// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mqtt-message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MqttMessage _$MqttMessageFromJson(Map<String, dynamic> json) => MqttMessage(
      id: json['id'] as int?,
      msg: json['msg'] as String?,
      time: json['time'] as String?,
    );

Map<String, dynamic> _$MqttMessageToJson(MqttMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'msg': instance.msg,
      'time': instance.time,
    };
