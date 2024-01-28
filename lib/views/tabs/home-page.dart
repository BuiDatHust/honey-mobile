import 'package:flutter/material.dart';
import 'package:honey_mobile/models/profile/profile.dart';
import 'package:honey_mobile/viewmodels/home-page.dart';
import 'package:honey_mobile/viewmodels/token.dart';
import 'package:honey_mobile/widgets/circular-loading-widget.dart';
import 'package:honey_mobile/widgets/user-card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    HomePageViewModel homePageViewModel =
        Provider.of<HomePageViewModel>(context);
    TokenViewModel tokenViewModel = Provider.of<TokenViewModel>(context);
    bool isLoading = homePageViewModel.isLoading || tokenViewModel.isLoading;

    if (isLoading) {
      return Scaffold(body: CircularLoadingWidget());
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            children: [
              InkWell(
                child: Draggable<Profile>(
                  data: homePageViewModel.users[homePageViewModel.index],
                  feedback: UserCard(
                      user: homePageViewModel.users[homePageViewModel.index]),
                  childWhenDragging: UserCard(
                      user: homePageViewModel.users[homePageViewModel.index]),
                  onDragEnd: (drag) async {
                    double velocityX = drag.velocity.pixelsPerSecond.dx;
                    if (velocityX < -size.width / 3) {
                      print("reject");
                      if (homePageViewModel.index <
                          homePageViewModel.users.length - 1) {
                        await homePageViewModel.react(
                            context, tokenViewModel.token.access_token, false);
                        await homePageViewModel.increaseIndex(
                            context, tokenViewModel.token.access_token);
                        return;
                      }
                    }

                    if (velocityX > size.width / 3) {
                      print("liked");
                      if (homePageViewModel.index <
                          homePageViewModel.users.length - 1) {
                        await homePageViewModel.react(
                            context, tokenViewModel.token.access_token, true);
                        await homePageViewModel.increaseIndex(
                            context, tokenViewModel.token.access_token);
                        return;
                      }
                    }
                  },
                  child: UserCard(
                      user: homePageViewModel.users[homePageViewModel.index]),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    HomePageViewModel homePageViewModel =
        Provider.of<HomePageViewModel>(context, listen: false);
    TokenViewModel tokenViewModel =
        Provider.of<TokenViewModel>(context, listen: false);

    if (tokenViewModel.isLoading) {
      return;
    }
    homePageViewModel.getListProfile(
        context, tokenViewModel.token.access_token);

    super.initState();
  }
}
