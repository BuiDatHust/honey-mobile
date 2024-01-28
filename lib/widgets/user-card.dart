import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:honey_mobile/animations/liked.dart';
import 'package:honey_mobile/models/profile/profile.dart';
import 'package:honey_mobile/models/user/show-media.dart';
import 'package:honey_mobile/viewmodels/home-page.dart';
import 'package:honey_mobile/viewmodels/token.dart';
import 'package:honey_mobile/views/profile/user-detail.dart';
import 'package:honey_mobile/views/tabs/user-video-card.dart';
import 'package:honey_mobile/widgets/choice-button.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class UserCard extends StatefulWidget {
  final Profile user;
  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool isAnimating = false;
  bool isLiked = false;
  double meters = 0;
  bool isDisliked = false;
  double? lat;
  double? long;
  double distance = 0;
  TapDownDetails? tapDownDetails;
  int indexMedia = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int mediaLen = widget.user.show_medias!.length;
    HomePageViewModel homePageViewModel =
        Provider.of<HomePageViewModel>(context);
    TokenViewModel tokenViewModel = Provider.of<TokenViewModel>(context);

    return GestureDetector(
        onTapDown: (details) {
          if (details.localPosition.dx >
                  MediaQuery.of(context).size.width / 2 &&
              indexMedia < mediaLen - 1) {
            setState(() {
              indexMedia++;
            });
          }

          if (details.localPosition.dx <=
                  MediaQuery.of(context).size.width / 2 &&
              indexMedia > 0) {
            setState(() {
              indexMedia--;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
          child: Stack(
            children: [
              SizedBox(
                height: size.height / 1.4,
                width: size.width,
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: const Offset(0, 3),
                            spreadRadius: 4,
                            blurRadius: 10),
                      ],
                      image: (widget.user.show_medias![indexMedia] as ShowMedia)
                              .url
                              .contains("mp4")
                          ? null
                          : DecorationImage(
                              image: NetworkImage((widget.user
                                      .show_medias![indexMedia] as ShowMedia)
                                  .url),
                              fit: BoxFit.cover),
                    ),
                    child: (widget.user.show_medias![indexMedia] as ShowMedia)
                            .url
                            .contains("mp4")
                        ? UserVideoCard(
                            videoUrl: (widget.user.show_medias![indexMedia]
                                    as ShowMedia)
                                .url)
                        : null,
                  ),
                  Positioned(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        mediaLen,
                        (index) => Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 4,
                                width: size.width * 0.8 / mediaLen,
                                decoration: BoxDecoration(
                                  color: index == indexMedia
                                      ? Colors.white
                                      : const Color.fromARGB(255, 138, 134, 134)
                                          .withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            )),
                  )),
                  Container(
                      decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  )),
                  Positioned(
                    bottom: 10,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(50, 30),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    alignment: Alignment.centerLeft),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserDetail(
                                              user: widget.user,
                                            )),
                                  );
                                },
                                child: Text(
                                  widget.user.firstname ?? '',
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.info_outline_rounded,
                              color: Colors.white,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${widget.user.age.toString()}, ',
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              'aaaa',
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: GridView.count(
                            padding: const EdgeInsets.only(right: 90),
                            shrinkWrap: true,
                            childAspectRatio: 18 / 6,
                            crossAxisCount: 4,
                            children: widget.user.passions!.map((interest) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                    width: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromARGB(
                                              97, 214, 218, 215)
                                          .withOpacity(0.5),
                                    ),
                                    child: Center(
                                        child: Text(
                                      interest,
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 12, color: Colors.white),
                                    ))),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isDisliked = true;
                                  });
                                },
                                child: ChoiceButton(
                                  height: 60,
                                  isSvg: true,
                                  hasGradient: false,
                                  linear1: Colors.red.withOpacity(.8),
                                  linear2: Colors.redAccent,
                                  path: 'assets/svgs/close_icon.svg',
                                  width: 60,
                                  color: Colors.white,
                                  icon: Icons.clear_rounded,
                                  size: 25,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isAnimating = true;
                                    isLiked = true;
                                  });
                                },
                                child: const ChoiceButton(
                                  hasGradient: false,
                                  isSvg: true,
                                  height: 60,
                                  width: 60,
                                  path: 'assets/svgs/like_icon.svg',
                                  color: Colors.white,
                                  icon: Icons.favorite,
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]),
              ),
              Positioned(
                left: 50,
                right: 50,
                top: 50,
                bottom: 50,
                child: Opacity(
                  opacity: isAnimating ? 1 : 0,
                  child: HeartAnimationWidget(
                    onEnd: () async {
                      setState(() {
                        isAnimating = false;
                      });

                      await homePageViewModel.react(
                          context, tokenViewModel.token.access_token, true);
                      await homePageViewModel.increaseIndex(
                          context, tokenViewModel.token.access_token);
                    },
                    duration: const Duration(milliseconds: 700),
                    isAnimation: isAnimating,
                    child: Container(
                      height: 20,
                      width: 20,
                      color: Colors.transparent,
                      child: Lottie.asset(
                        'assets/animations/love.json',
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 50,
                right: 50,
                top: 50,
                bottom: 50,
                child: Opacity(
                  opacity: isDisliked ? 1 : 0,
                  child: HeartAnimationWidget(
                    onEnd: () async {
                      setState(() {
                        isDisliked = false;
                      });
                      await homePageViewModel.react(
                          context, tokenViewModel.token.access_token, false);
                      await homePageViewModel.increaseIndex(
                          context, tokenViewModel.token.access_token);
                    },
                    duration: const Duration(milliseconds: 700),
                    isAnimation: isDisliked,
                    child: SvgPicture.asset(
                      'assets/svgs/close_icon.svg',
                      height: 55,
                      width: 55,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}
