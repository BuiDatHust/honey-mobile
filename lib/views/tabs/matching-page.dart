import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:honey_mobile/services/chat.dart';
import 'package:honey_mobile/services/friend.dart';
import 'package:honey_mobile/viewmodels/chat-list.dart';
import 'package:honey_mobile/viewmodels/friend.dart';
import 'package:honey_mobile/viewmodels/new-friend.dart';
import 'package:honey_mobile/viewmodels/token.dart';
import 'package:honey_mobile/viewmodels/user.dart';
import 'package:honey_mobile/views/tabs/list-matched-tab.dart';
import 'package:honey_mobile/views/tabs/list-message-tab.dart';
import 'package:honey_mobile/views/tabs/list-recently-match.dart';
import 'package:provider/provider.dart';

class MatchingPage extends StatefulWidget {
  const MatchingPage({Key? key}) : super(key: key);

  @override
  State<MatchingPage> createState() => _MatchingPageState();
}

class _MatchingPageState extends State<MatchingPage> {
  @override
  Widget build(BuildContext context) {
    NewFriendViewModel newFriendViewModel =
        Provider.of<NewFriendViewModel>(context);
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    ChatListViewModel chatListViewModel =
        Provider.of<ChatListViewModel>(context);
    FriendViewModel friendViewModel = Provider.of<FriendViewModel>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey.withAlpha(40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            const Icon(
                              AntIcons.searchOutlined,
                              size: 17,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Search ${newFriendViewModel.friends.length.toString()} Matches',
                              // 'Search n Matches',
                              style: GoogleFonts.aBeeZee(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Recently Matched',
                        style: GoogleFonts.aBeeZee(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                    SizedBox(
                        height: 100,
                        child: SizedBox(
                          height: 100,
                          child: ListRecentlyMatch(
                              newFriendViewModel: newFriendViewModel,
                              userViewModel: userViewModel),
                        )),
                    TabBar(
                        padding: EdgeInsets.zero,
                        labelPadding: EdgeInsets.zero,
                        indicatorColor: Theme.of(context).colorScheme.secondary,
                        labelColor: Theme.of(context).colorScheme.secondary,
                        unselectedLabelColor: Colors.grey,
                        tabs: const [
                          Tab(
                            text: "Messages",
                          ),
                          Tab(
                            text: "Matches",
                          )
                        ]),
                    Expanded(
                      child: TabBarView(children: [
                        ListMessageTab(
                            chatListViewModel: chatListViewModel,
                            userViewModel: userViewModel),
                        ListMatchedTab(
                          friendViewModel: friendViewModel,
                          userViewModel: userViewModel,
                        )
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    handleInit();
    super.initState();
  }

  handleInit() async {
    FriendService friendService = FriendService();
    TokenViewModel tokenViewModel =
        Provider.of<TokenViewModel>(context, listen: false);
    NewFriendViewModel newFriendViewModel =
        Provider.of<NewFriendViewModel>(context, listen: false);
    newFriendViewModel.setService(friendService);
    ChatListViewModel chatListViewModel =
        Provider.of<ChatListViewModel>(context, listen: false);
    chatListViewModel.setService(ChatService());
    FriendViewModel friendViewModel =
        Provider.of<FriendViewModel>(context, listen: false);
    friendViewModel.setService(FriendService());

    await newFriendViewModel.getListNewFriend(
        context, tokenViewModel.token.access_token);
    await chatListViewModel.getListChat(
        context, tokenViewModel.token.access_token);
    await friendViewModel.getListFriend(
        context, tokenViewModel.token.access_token);
  }
}
