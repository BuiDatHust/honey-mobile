import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:honey_mobile/models/matching/chat.dart';
import 'package:honey_mobile/models/user/users.dart';
import 'package:honey_mobile/viewmodels/chat-list.dart';
import 'package:honey_mobile/viewmodels/user.dart';
import 'package:honey_mobile/views/tabs/chat-screen.dart';
import 'package:honey_mobile/widgets/small-image.dart';

class ListMessageTab extends StatefulWidget {
  final ChatListViewModel chatListViewModel;
  final UserViewModel userViewModel;

  const ListMessageTab(
      {super.key,
      required this.chatListViewModel,
      required this.userViewModel});

  @override
  State<ListMessageTab> createState() => _ListMessageTabState();
}

class _ListMessageTabState extends State<ListMessageTab> {
  @override
  Widget build(BuildContext context) {
    List<Chat> chats = widget.chatListViewModel.chats;
    User? currentUser = widget.userViewModel.user;

    if (widget.chatListViewModel.isLoading) {
      return const SizedBox(
        height: 50.0,
        width: 50.0,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (widget.chatListViewModel.chats.isEmpty) {
      return const Text("No message!");
    }

    return ListView.builder(
        shrinkWrap: true,
        itemCount: chats.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => Messaging(
                            chatId: chats[index].id,
                            targetUserId: chats[index].user.id,
                            currentUserId: currentUser!.id,
                            cureentUserphtoUrl:
                                currentUser.show_medias![0]!.url,
                            photoUrl: chats[index].user.show_medias[0].url,
                            username: chats[index].user.firstname,
                          )));
            },
            child: Row(
              children: [
                UserImageSmall(
                  height: 65,
                  width: 65,
                  url: chats[index].user.show_medias[0].url,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(chats[index].user.firstname,
                        style: GoogleFonts.aBeeZee(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 2),
                    Text(chats[index].last_message.content,
                        style: GoogleFonts.aBeeZee(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        )),
                    const SizedBox(height: 5),
                    Text('4 year ago',
                        style: GoogleFonts.aBeeZee(
                            fontSize: 12, color: Colors.grey)),
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
  }
}
