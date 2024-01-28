import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:honey_mobile/core/network/mqtt-client.dart';
import 'package:honey_mobile/models/matching/message.dart';
import 'package:honey_mobile/services/message.dart';
import 'package:honey_mobile/viewmodels/message.dart';
import 'package:honey_mobile/viewmodels/mqtt-chat.dart';
import 'package:honey_mobile/viewmodels/token.dart';
import 'package:honey_mobile/views/tabs/chat-container.dart';
import 'package:provider/provider.dart';

class Messaging extends StatefulWidget {
  final String chatId;
  final String currentUserId;
  final String targetUserId;
  final String username;
  final String photoUrl;
  final String cureentUserphtoUrl;
  late MQTTService service;
  List<String> topics = [];

  Messaging(
      {Key? key,
      required this.chatId,
      required this.username,
      required this.photoUrl,
      required this.cureentUserphtoUrl,
      required this.targetUserId,
      required this.currentUserId})
      : super(key: key);

  @override
  _MessagingState createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  final List<String> quickmessages = [
    'Howdy!',
    'Hi!',
    'Wassup',
    'Hey',
    'Hello',
    'Heyy',
  ];

  @override
  Widget build(BuildContext context) {
    String currentUserId = widget.currentUserId;
    MessageViewModel messageViewModel = Provider.of<MessageViewModel>(context);
    MqttChatViewModel mqttChatViewModel =
        Provider.of<MqttChatViewModel>(context);
    mqttChatViewModel.setMessage(messageViewModel.messages);
    List<Message> messages = mqttChatViewModel.messages;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 27,
                    backgroundImage: NetworkImage(widget.photoUrl ?? ''),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.username ?? 'Messaging',
                        style: GoogleFonts.aBeeZee(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'active now',
                        style: GoogleFonts.aBeeZee(
                          fontSize: 12,
                          color: Colors.greenAccent,
                        ),
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/images/phone-call-in-chat.png',
                        height: 25,
                        width: 25,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/images/zoom.png',
                        height: 25,
                        width: 25,
                      ))
                ],
              )
            ],
          )),
      body: Column(
        children: [
          Expanded(
              child:
                  _getMessageWithSpecificSenderBuilder(messages, currentUserId))
        ],
      ),
      bottomSheet: BottomSheet(
          backgroundColor: Colors.transparent,
          onClosing: () {},
          builder: (context) {
            return ChatContainer(
                mqttChatViewModel: mqttChatViewModel, topics: widget.topics);
          }),
    );
  }

  @override
  void dispose() {
    widget.service.disConnectMQTT();
    super.dispose();
  }

  @override
  void initState() {
    MessageService messageService = MessageService();
    MessageViewModel messageViewModel =
        Provider.of<MessageViewModel>(context, listen: false);
    TokenViewModel tokenViewModel =
        Provider.of<TokenViewModel>(context, listen: false);
    MqttChatViewModel mqttChatViewModel =
        Provider.of<MqttChatViewModel>(context, listen: false);

    messageViewModel.setService(messageService);

    String chatId = widget.chatId;
    mqttChatViewModel.setTopics(chatId);
    mqttChatViewModel.initBroker();
    mqttChatViewModel.setUserAndChat(
        widget.currentUserId, widget.chatId, widget.targetUserId);

    messageViewModel.getMessages(
        tokenViewModel.token.access_token, widget.chatId);

    super.initState();
  }

  Widget _getContentMessage(
      int index, List<Message> messages, String currentUserId) {
    switch (messages[index].type_content) {
      case 'TEXT':
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (messages[index].reciever_user_id == currentUserId
                ? Colors.grey.shade200
                : Colors.blue[200]),
          ),
          padding: const EdgeInsets.all(16),
          child: Text(
            messages[index].content,
            style: const TextStyle(fontSize: 15),
          ),
        );
      case 'IMAGE':
        return Container(
          height: 150,
          width: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(messages[index].content),
            ),
          ),
        );
      case 'AUDIO':
      case 'VIDEO':
      default:
        return const Text('error type content');
    }
  }

  _getMessageWithSpecificSenderBuilder(
      List<Message> messages, String currentUserId) {
    if (messages.isEmpty) {
      return Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Column(
            children: [
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(widget.photoUrl ?? ''))),
                      ),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    widget.cureentUserphtoUrl ?? ''))),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 3,
                            color: Theme.of(context).colorScheme.secondary),
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: SizedBox(
                        height: 25,
                        width: 25,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Center(
                            child: Image.asset(
                              'assets/images/connect.png',
                              color: Theme.of(context).colorScheme.secondary,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "You Connected with ${widget.username} on Thu 23 Febraury, Message them now!",
                textAlign: TextAlign.center,
                style: GoogleFonts.aBeeZee(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.24,
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ListView.builder(
              itemCount: quickmessages.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            spreadRadius: 1,
                          )
                        ],
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                        child: Text(
                      quickmessages[index],
                      style: GoogleFonts.aBeeZee(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    )),
                  ),
                );
              },
            ),
          )
        ],
      );
    }

    return ListView.builder(
      key: const Key('randomString(20)'),
      itemCount: messages.length,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          padding:
              const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
          child: Align(
            alignment: (messages[index].reciever_user_id == currentUserId
                ? Alignment.topLeft
                : Alignment.topRight),
            child: _getContentMessage(index, messages, currentUserId),
          ),
        );
      },
    );
  }
}
