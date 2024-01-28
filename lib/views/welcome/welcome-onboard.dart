import 'package:flutter/material.dart';
import 'package:honey_mobile/views/onboarding/onboarding.dart';

class WelcomeOnboardPage extends StatelessWidget {
  const WelcomeOnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Center(
                  child: Image.asset(
                "assets/images/logo.png",
                height: 40,
                width: 40,
              )),
              const Text(
                "Welcome to Tinder",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const Text(
                "Please follow these rules",
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
          Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Be yourself",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const Text(
                    "Make sure your photos, age and bio are true to who you are",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Be yourself",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const Text(
                    "Make sure your photos, age and bio are true to who you are",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Be yourself",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const Text(
                    "Make sure your photos, age and bio are true to who you are",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Be yourself",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const Text(
                    "Make sure your photos, age and bio are true to who you are",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrangeAccent,
                      elevation: 0,
                      fixedSize: const Size(500, 40)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OnboardingScreen()),
                    );
                  },
                  child: const Text('I Agree', style: TextStyle(fontSize: 20, color: Colors.white))))
        ],
      ),
    )));
  }
}
