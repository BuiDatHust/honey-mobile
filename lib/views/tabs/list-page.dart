import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:honey_mobile/widgets/everyone-likes.dart';
import 'package:honey_mobile/widgets/me-likes.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class PremiumDialog extends StatelessWidget {
  const PremiumDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: Material(
            child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      Column(children: [
                        Text('Get Discover Premium',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 20,
                            )),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ]),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

class _ListPageState extends State<ListPage>
    with AutomaticKeepAliveClientMixin<ListPage> {
  final bool _fromTop = true;
  TabController? tabController;
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(builder: (context) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Column(children: [
                  TabBar(
                    controller: tabController,
                    indicatorColor: Colors.grey[500],
                    labelColor: Colors.black,
                    labelStyle: GoogleFonts.aBeeZee(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                    unselectedLabelColor: const Color.fromARGB(255, 58, 51, 51),
                    tabs: const [
                      Tab(
                        text: '10 Likes',
                      ),
                      Tab(text: '10 Picks'),
                    ],
                  ),
                  const Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: TabBarView(
                      children: [
                        EveryoneLike(),
                        MeLike(),
                      ],
                    ),
                  ))
                ]),
                Positioned(
                  bottom: 10,
                  left: 35,
                  right: 35,
                  child: GestureDetector(
                    onTap: () {
                      showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: MaterialLocalizations.of(context)
                              .modalBarrierDismissLabel,
                          barrierColor: Colors.black.withOpacity(0.5),
                          transitionDuration: const Duration(milliseconds: 700),
                          transitionBuilder: (context, anim1, anim2, child) {
                            return SlideTransition(
                              position: Tween(
                                      begin: const Offset(0, -1),
                                      end: const Offset(0, 0))
                                  .animate(anim1),
                              child: child,
                            );
                          },
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return const PremiumDialog();
                          });
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [
                            0.1,
                            0.9,
                          ],
                          colors: [
                            Colors.redAccent,
                            Colors.redAccent,
                          ],
                        ),
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                            DefaultTabController.of(context).index == 0
                                ? 'See full list'.toUpperCase()
                                : 'See who picked you'.toUpperCase(),
                            style: GoogleFonts.aBeeZee(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
