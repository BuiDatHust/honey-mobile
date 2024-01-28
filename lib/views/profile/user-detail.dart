import 'package:flutter/material.dart';
import 'package:honey_mobile/models/profile/profile.dart';
import 'package:honey_mobile/widgets/choice-button.dart';

class UserDetail extends StatefulWidget {
  final Profile user;
  const UserDetail({super.key, required this.user});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  int indexMedia = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String firstname = widget.user.firstname ?? "bui dat";
    String age = widget.user.age.toString();
    int mediaLen = widget.user.show_medias!.length;

    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                  child: GestureDetector(
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
                child: Container(
                  height: size.height * 0.6,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(""), fit: BoxFit.cover),
                  ),
                ),
              )),
              Positioned(
                  top: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        mediaLen,
                        (index) => Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 4,
                                width: size.width / mediaLen,
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
              Positioned(
                  bottom: 0,
                  right: 20,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_circle_down,
                        size: 50,
                        fill: 0.9,
                        color: Colors.red,
                      ))),
              Positioned(
                  bottom: 10,
                  right: 180,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {});
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
                  ))
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$firstname $age",
                  style: const TextStyle(color: Colors.black, fontSize: 30),
                ),
                const Row(
                  children: [Icon(Icons.school), Text("Hoc vien ngan hang")],
                ),
                const Row(
                  children: [Icon(Icons.home), Text("Lives in Ha Noi")],
                ),
                const Row(
                  children: [
                    Icon(Icons.location_city),
                    Text("2 kilometer away")
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 1,
            color: const Color.fromARGB(255, 228, 226, 226),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Text("My bio"),
          ),
          Container(
            height: 1,
            color: const Color.fromARGB(255, 228, 226, 226),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              children: [
                GestureDetector(
                  child: const Text(
                    "Block bui dat",
                    style: TextStyle(
                        color: Color.fromARGB(255, 41, 37, 37), fontSize: 20),
                  ),
                ),
                const Text("You wont see them; they wont see you.")
              ],
            ),
          ),
          Container(
            height: 1,
            color: const Color.fromARGB(255, 228, 226, 226),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                children: [
                  GestureDetector(
                    child: const Text(
                      "Report bui dat",
                      style: TextStyle(
                          color: Color.fromARGB(255, 41, 37, 37), fontSize: 20),
                    ),
                  ),
                  const Text("You wont see them; they wont see you.")
                ],
              ))
        ],
      )),
    );
  }
}
