import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:honey_mobile/core/constants/matching.dart';
import 'package:honey_mobile/services/friend.dart';
import 'package:honey_mobile/viewmodels/pending-reaction.dart';
import 'package:honey_mobile/viewmodels/token.dart';
import 'package:honey_mobile/widgets/circular-loading-widget.dart';
import 'package:provider/provider.dart';

class MeLike extends StatefulWidget {
  const MeLike({Key? key}) : super(key: key);

  @override
  _MeLikeState createState() => _MeLikeState();
}

class _MeLikeState extends State<MeLike> {
  @override
  Widget build(BuildContext context) {
    PendingReactionModel pendingReactionModel =
        Provider.of<PendingReactionModel>(context);

    if (pendingReactionModel.isMeLoading) {
      return CircularLoadingWidget();
    }

    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          'Upgrade to Premium to see the full list of everyone you liked.',
          textAlign: TextAlign.center,
          style: GoogleFonts.aBeeZee(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 30),
        Expanded(
            child: pendingReactionModel.mePendingReactions.isEmpty
                ? const Text("No pending reaction!")
                : GridView.builder(
                    itemCount: pendingReactionModel.mePendingReactions.length,
                    addAutomaticKeepAlives: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 7 / 10,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                          onDoubleTap: () {},
                          child: Container(
                              height: 180,
                              width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(pendingReactionModel
                                        .mePendingReactions[index]
                                        .user
                                        .show_medias[0]
                                        .url)),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              pendingReactionModel
                                                  .mePendingReactions[index]
                                                  .user
                                                  .firstname,
                                              style: GoogleFonts.aBeeZee(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                          ],
                                        ),
                                        Text(
                                          'Expires in: '
                                          '1 day',
                                          style: GoogleFonts.aBeeZee(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))),
                        ),
                      );
                    },
                  )),
      ],
    );
  }

  @override
  void initState() {
    PendingReactionModel pendingReactionModel =
        Provider.of<PendingReactionModel>(context, listen: false);
    TokenViewModel tokenViewModel =
        Provider.of<TokenViewModel>(context, listen: false);
    pendingReactionModel.setService(FriendService());

    pendingReactionModel.getPendingReaction(context,
        tokenViewModel.token.access_token, MatchingConstant.ME_PENDING);

    super.initState();
  }
}
