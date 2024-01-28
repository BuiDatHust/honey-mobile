import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:honey_mobile/models/matching/friend.dart';
import 'package:honey_mobile/models/user/users.dart';
import 'package:honey_mobile/viewmodels/new-friend.dart';
import 'package:honey_mobile/viewmodels/user.dart';
import 'package:honey_mobile/views/tabs/chat-screen.dart';
import 'package:honey_mobile/widgets/small-image.dart';

class ListRecentlyMatch extends StatefulWidget {
  final NewFriendViewModel newFriendViewModel;
  final UserViewModel userViewModel;

  const ListRecentlyMatch(
      {Key? key, required this.newFriendViewModel, required this.userViewModel})
      : super(key: key);

  @override
  State<ListRecentlyMatch> createState() => _ListRecentlyMatchState();
}

class _ListRecentlyMatchState extends State<ListRecentlyMatch> {
  @override
  Widget build(BuildContext context) {
    List<Friend> friends = widget.newFriendViewModel.friends;
    User? currentUser = widget.userViewModel.user;

    if (widget.newFriendViewModel.isLoading) {
      return const SizedBox(
        height: 30.0,
        width: 30.0,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (friends.isEmpty) {
      return const Text("No recently match!");
    }

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: friends.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => Messaging(
                                  chatId: friends[index].chat_seeting_id,
                                  targetUserId: friends[index].user.id,
                                  currentUserId: currentUser!.id,
                                  cureentUserphtoUrl:
                                      currentUser.show_medias![0]!.url,
                                  photoUrl:
                                      friends[index].user.show_medias[0].url,
                                  username: friends[index].user.firstname,
                                )));
                  },
                  child: UserImageSmall(
                      height: 60,
                      width: 60,
                      url: friends[index].user.show_medias[0].url),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  _getFirstname(friends[index].user.firstname),
                  style: GoogleFonts.aBeeZee(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
  }

  String _getFirstname(String? firstname) {
    if (firstname == null) {
      return "N/A";
    }

    return firstname.length > 7 ? firstname.substring(0, 7) : firstname;
  }
}
