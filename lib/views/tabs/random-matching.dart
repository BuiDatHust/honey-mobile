import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:honey_mobile/views/random-matching/random-chat.dart';
import 'package:honey_mobile/views/random-matching/random-phone-call.dart';

class RandomMatchingPage extends StatefulWidget {
  const RandomMatchingPage({Key? key}) : super(key: key);

  @override
  _RandomMatchingPageState createState() => _RandomMatchingPageState();
}

class _RandomMatchingPageState extends State<RandomMatchingPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'You can join chat room or voice room to random find a friend',
              textAlign: TextAlign.center,
              style: GoogleFonts.aBeeZee(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RandomChatPage()),
                    );
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        color: const Color.fromARGB(255, 209, 118, 148),
                        height: MediaQuery.of(context).size.height - 300,
                        width: MediaQuery.of(context).size.width / 2 - 20,
                      ),
                      Positioned(
                        height: 200,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                'assets/images/bubble-chat.png',
                                height: 100,
                                width: 100,
                                color: Colors.pinkAccent,
                              ),
                              const Text(
                                "Chat",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "1898999999 user online",
                                style: TextStyle(fontSize: 15),
                              )
                            ]),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RandomPhoneCallPage()),
                    );
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        color: const Color.fromARGB(255, 93, 128, 168),
                        height: MediaQuery.of(context).size.height - 300,
                        width: MediaQuery.of(context).size.width / 2 - 20,
                      ),
                      Positioned(
                        height: 200,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                'assets/images/phone-call.png',
                                height: 100,
                                width: 100,
                                color: const Color.fromARGB(255, 48, 71, 146),
                              ),
                              const Text(
                                "Phone",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "18983322 user online",
                                style: TextStyle(fontSize: 15),
                              )
                            ]),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
