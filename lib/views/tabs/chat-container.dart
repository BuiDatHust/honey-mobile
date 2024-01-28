import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:honey_mobile/viewmodels/mqtt-chat.dart';
import 'package:honey_mobile/viewmodels/token.dart';
import 'package:provider/provider.dart';

class ChatContainer extends StatefulWidget {
  final MqttChatViewModel mqttChatViewModel;
  final List<String> topics;

  const ChatContainer({
    Key? key,
    required this.mqttChatViewModel,
    required this.topics,
  }) : super(key: key);

  @override
  State<ChatContainer> createState() => _ChatContainerState();
}

class _ChatContainerState extends State<ChatContainer> {
  TextEditingController controller = TextEditingController();
  String typeContent = "TEXT";

  @override
  Widget build(BuildContext context) {
    TokenViewModel tokenViewModel =
        Provider.of<TokenViewModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.mic_none,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: GoogleFonts.aBeeZee(
                        color: Colors.grey,
                      ),
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              FloatingActionButton(
                onPressed: () {
                  widget.mqttChatViewModel.publishMessage(
                      typeContent,
                      "PRIVATE",
                      tokenViewModel.token.access_token,
                      controller.text);
                  controller.text = "";
                },
                backgroundColor: Theme.of(context).primaryColorLight,
                elevation: 0,
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
}
