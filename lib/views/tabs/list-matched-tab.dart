import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:honey_mobile/models/matching/friend.dart';
import 'package:honey_mobile/models/user/users.dart';
import 'package:honey_mobile/viewmodels/friend.dart';
import 'package:honey_mobile/viewmodels/user.dart';
import 'package:honey_mobile/views/tabs/chat-screen.dart';
import 'package:honey_mobile/widgets/small-image.dart';

class ListMatchedTab extends StatefulWidget {
  final FriendViewModel friendViewModel;
  final UserViewModel userViewModel;

  const ListMatchedTab(
      {super.key, required this.friendViewModel, required this.userViewModel});

  @override
  State<ListMatchedTab> createState() => _ListMatchedTabState();
}

class _ListMatchedTabState extends State<ListMatchedTab> {
  @override
  Widget build(BuildContext context) {
    List<Friend> chats = widget.friendViewModel.friends;
    User? currentUser = widget.userViewModel.user;

    if (widget.friendViewModel.isLoading) {
      return const SizedBox(
        height: 50.0,
        width: 50.0,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (widget.friendViewModel.friends.isEmpty) {
      return const Text("No friend!");
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
