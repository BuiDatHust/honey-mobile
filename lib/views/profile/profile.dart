import 'package:flutter/material.dart';
import 'package:honey_mobile/models/auth/token.dart';
import 'package:honey_mobile/viewmodels/auth.dart';
import 'package:honey_mobile/viewmodels/token.dart';
import 'package:honey_mobile/viewmodels/user.dart';
import 'package:honey_mobile/views/edit-profile/edit-profile.dart';
import 'package:honey_mobile/views/settings/setting-page.dart';
import 'package:honey_mobile/widgets/circular-loading-widget.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    AuthViewModel authViewModel = Provider.of<AuthViewModel>(context);
    TokenViewModel tokenViewModel = Provider.of<TokenViewModel>(context);
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: null,
      body: authViewModel.isLoading
          ? CircularLoadingWidget(
              height: 200,
              width: 200,
            )
          : Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 230, 225, 225),
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 135.0)),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Stack(
                          children: [
                            const Align(
                                child: Text(
                              "Profile",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            )),
                            Positioned(
                                left: 0,
                                top: 0,
                                bottom: 0,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.arrow_back))),
                          ],
                        ),
                        Column(
                          children: [
                            Stack(
                              children: [
                                CircularPercentIndicator(
                                  radius: 68.0,
                                  lineWidth: 5.0,
                                  percent: 0.6,
                                  startAngle: 180.0,
                                  center: CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage(userViewModel
                                        .user!.show_medias![0]!.url),
                                  ),
                                  progressColor: Colors.green,
                                ),
                                Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 50,
                                      height: 30,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        color: Color.fromARGB(255, 42, 146, 60),
                                      ),
                                      child: Text(
                                          "${userViewModel.user!.completation_percentage}% completed",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${userViewModel.user!.firstname}, ${userViewModel.user!.age}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 224, 223, 223),
                                            blurRadius: 2,
                                            offset:
                                                Offset(2, 4), // Shadow position
                                          ),
                                        ],
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(60)),
                                    child: IconButton(
                                      icon: const Icon(Icons.settings,
                                          size: 30, weight: 1000),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SettingPage()),
                                        );
                                      },
                                    ),
                                  ),
                                  const Text(
                                    "SETTINGS",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 224, 223, 223),
                                              blurRadius: 2,
                                              offset: Offset(
                                                  2, 4), // Shadow position
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(60)),
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const EditProfile()));
                                          },
                                          icon: const Icon(Icons.edit,
                                              size: 30, weight: 1000)),
                                    ),
                                    const Text(
                                      "EDIT PROFILE",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 224, 223, 223),
                                            blurRadius: 2,
                                            offset:
                                                Offset(2, 4), // Shadow position
                                          ),
                                        ],
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(60)),
                                    child: IconButton(
                                        onPressed: () async {
                                          authViewModel.logout(
                                              context,
                                              "SPECIFIC",
                                              tokenViewModel
                                                  .token.access_token);
                                          tokenViewModel.token = const Token(
                                              access_token: "",
                                              refresh_token: "",
                                              device_id: "");
                                        },
                                        icon: const Icon(Icons.logout,
                                            size: 30, weight: 1000)),
                                  ),
                                  const Text(
                                    "LOG OUT",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Honey Platium",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              minimumSize: const Size(100.0, 40.0),
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 70, vertical: 10)),
                          onPressed: () {},
                          child: const Text('LEARN MORE',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black)))
                    ],
                  ),
                )
              ],
            ),
    );
  }

  handleInitState() async {}
}
