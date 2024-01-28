import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

class RandomChatPage extends StatefulWidget {
  const RandomChatPage({Key? key}) : super(key: key);

  @override
  _RandomChatPageState createState() => _RandomChatPageState();
}

class _RandomChatPageState extends State<RandomChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 4, 48),
      appBar: null,
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 40,
              ),
              const Text(
                "Random Chat",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.white,
                  icon: const Icon(Icons.exit_to_app))
            ],
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 250.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 1),
              enlargeCenterPage: true,
              viewportFraction: 0.2,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              initialPage: 3,
              autoPlayCurve: Curves.linear,
            ),
            items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return RandomAvatar(DateTime.now().toIso8601String(),
                      height: 200, width: 200);
                },
              );
            }).toList(),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Conneting...",
            style: TextStyle(
                color: Colors.pink, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              "You are in a queue people. please wait a few minute",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const Center(
            child: Text(
              "to match new people",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  backgroundColor: Colors.pink,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 10.0)),
              onPressed: () {},
              child: const Text('Speed up', style: TextStyle(fontSize: 20))),
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              "Speed up your matching",
              style: TextStyle(color: Colors.pink),
            ),
          ),
        ],
      ),
    );
  }
}
