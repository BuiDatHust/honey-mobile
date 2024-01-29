import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:honey_mobile/core/network/mqtt-client.dart';
import 'package:honey_mobile/models/matching/message.dart';
import 'package:honey_mobile/models/mqtt-message/message-in-chat-payload.dart';

class MqttChatViewModel extends ChangeNotifier {
  late MQTTService service;
  List<String> topics = [];
  List<Message> messages = [];
  String chat_id = "";
  String user_id = "";
  String targetUserId = "";
  String sendMessageTopic = "";

  handleRecievedMessage(String payload) {
    Map<String, dynamic> valueMap = json.decode(payload);
    Message message = Message.fromJson(valueMap);
    messages.add(message);
    notifyListeners();
  }

  initBroker() {
    service = MQTTService(
        host: 'quan.ddns.net',
        port: 1883,
        topics: topics,
        handleMessages: [handleRecievedMessage]);
    service.initializeMQTTClient();
    service.connectMQTT();
  }

  publishMessage(String typeContent, String typeMessage, String accessToken,
      String content) {
    MessageInChatPayload messageInChatPayload = MessageInChatPayload(
        user_id: targetUserId,
        chat_id: chat_id,
        content: content,
        type_content: typeContent,
        type_message: typeMessage,
        access_token: accessToken);
    var message = jsonEncode(messageInChatPayload.toJson());

    service.puslish(sendMessageTopic, message);
  }

  setMessage(List<Message> newMessage) {
    messages = newMessage;
  }

  setTopics(String chatId) {
    topics = ["message/$chatId"];
  }

  setUserAndChat(String userId, String chatId, String newTargetUserId) {
    user_id = userId;
    chat_id = chatId;
    targetUserId = newTargetUserId;
    sendMessageTopic = "send-message/$userId";
    print(sendMessageTopic);
  }
}
