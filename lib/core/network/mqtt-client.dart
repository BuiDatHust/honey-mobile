import 'dart:developer';

import 'package:honey_mobile/viewmodels/mqtt.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTService {
  final MQTTModel? model;

  final String? host;

  final int port;

  final List<String> topics;

  final List<void Function(String payload)> handleMessages;

  late MqttServerClient _client;

  bool isMe;

  MQTTService({
    this.host,
    required this.port,
    required this.topics,
    required this.handleMessages,
    this.model,
    this.isMe = false,
  });

  Future connectMQTT() async {
    try {
      await _client.connect();
    } on NoConnectionException catch (e) {
      log(e.toString());
      _client.disconnect();
    }
  }

  void disConnectMQTT() {
    try {
      _client.disconnect();
    } catch (e) {
      log(e.toString());
    }
  }

  void handleTopic(String recievedTopic, String payload) {
    for (int index = 0; index < topics.length; index++) {
      if (recievedTopic == recievedTopic) {
        handleMessages[index](payload);
      }
    }
  }

  void initializeMQTTClient() {
    _client = MqttServerClient(host!, 'honey-app')
      ..port = port
      ..logging(on: false)
      ..onDisconnected = onDisConnected
      ..onSubscribed = onSubscribed
      ..keepAlivePeriod = 20
      ..onConnected = onConnected;

    final connMess = MqttConnectMessage()
        .withClientIdentifier('honey-app')
        .withWillTopic('willTopic')
        .withWillMessage('willMessage')
        .startClean()
        .withWillQos(MqttQos.atMostOnce);
    print('Connecting....');
    _client.connectionMessage = connMess;
  }

  void onConnected() {
    log('Connected');

    try {
      for (int index = 0; index < topics.length; index++) {
        String topic = topics[index];
        _client.subscribe(topic, MqttQos.atMostOnce);
      }

      _client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;

        final String pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        handleTopic(c[0].topic, pt);
        print(
            'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void onDisConnected() {
    log('Disconnected');
  }

  void onSubscribed(String topic) {
    print('Subscription confirmed for topic $topic');
  }

  void puslish(String topic, String message) {
    try {
      if (_client.connectionStatus?.state == MqttConnectionState.connected) {
        final builder = MqttClientPayloadBuilder();
        builder.addString(message);
        _client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
        builder.clear();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void unSubscribe(String topic) {
    try {
      _client.unsubscribe(topic);
    } catch (e) {
      log(e.toString());
    }
  }
}
