import 'package:json_annotation/json_annotation.dart';

part 'mqtt-message.g.dart';

@JsonSerializable()
class MqttMessage {
  final int? id;

  final String? msg;
  final String? time;

  MqttMessage({
    this.id,
    this.msg,
    this.time,
  });

  // @override
  // int get hashCode =>
  //     msg.runtimeType.hashCode ^
  //     id.runtimeType.hashCode ^
  //     time.runtimeType.hashCode;

  // @override
  // bool operator ==(Object other) {
  //   return identical(this, other) &&
  //       (other is MqttMessage) &&
  //       other.msg == msg &&
  //       other.id == id &&
  //       other.time == time;
  // }

  factory MqttMessage.fromJson(Map<String, dynamic> json) =>
      _$MqttMessageFromJson(json);
  Map<String, dynamic> toJson() => _$MqttMessageToJson(this);
}
