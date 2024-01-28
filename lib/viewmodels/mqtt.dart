import 'package:flutter/cupertino.dart';
import 'package:honey_mobile/models/chat/messages.dart';

class MQTTModel extends ChangeNotifier {
  final _message = <Message>[];

  List<Message> get message => _message;

  void addMessage(Message message) {
    _message.add(message);
    notifyListeners();
  }
}
