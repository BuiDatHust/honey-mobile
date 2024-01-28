import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honey_mobile/viewmodels/token.dart';
import 'package:honey_mobile/viewmodels/user-setting.dart';
import 'package:honey_mobile/viewmodels/user.dart';
import 'package:honey_mobile/views/settings/setting-email-notification.dart';
import 'package:honey_mobile/views/settings/setting-email-page.dart';
import 'package:honey_mobile/views/settings/setting-phone-page.dart';
import 'package:honey_mobile/views/settings/setting-push-notification.dart';
import 'package:honey_mobile/widgets/circular-loading-widget.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  int selectedIndexAppearence = 0;
  RangeValues currentRangeValues = const RangeValues(0, 20);
  RangeValues currentRangeAgeValues = const RangeValues(18, 28);
  bool isShowPeopleInAge = false;
  bool isShowPeopleInDistance = false;
  String address = "";
  String locale = "";

  SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    UserSettingViewModel userSettingViewModel =
        Provider.of<UserSettingViewModel>(context);
    TokenViewModel tokenViewModel = Provider.of<TokenViewModel>(context);

    if (userViewModel.isLoading || userSettingViewModel.isLoading) {
      return CircularLoadingWidget();
    }

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 240, 239, 239),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1.0,
          actions: [
            TextButton(
                onPressed: () async {
                  await handleSaveSetting(
                      userSettingViewModel, tokenViewModel, userViewModel);
                  Navigator.pop(context);
                },
                child: const Text(
                  "Done",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.deepOrangeAccent),
                ))
          ],
          centerTitle: true,
          title: const Text(
            "SETTINGS",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.97,
              height: 80,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      width: 120,
                      height: 30,
                    ),
                    const Text(
                      "Level up every action with tinder",
                      style: TextStyle(
                          fontSize: 17, color: Color.fromARGB(255, 88, 81, 81)),
                    )
                  ]),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.97,
              height: 80,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      width: 120,
                      height: 30,
                    ),
                    const Text(
                      "Level up ervery action with tinder",
                      style: TextStyle(
                          fontSize: 17, color: Color.fromARGB(255, 88, 81, 81)),
                    )
                  ]),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Account settings",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      )
                    ]),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 150,
                  child: ListView(
                    children: [
                      Container(
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 223, 220, 220)),
                              bottom: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 223, 220, 220)),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Phone",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 73, 71, 71)),
                              ),
                              Row(
                                children: [
                                  Text(
                                    userSettingViewModel.phoneNumber,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 73, 71, 71)),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SettingPhonePage()),
                                        );
                                      },
                                      icon: Image.asset(
                                        "assets/images/next.png",
                                        width: 20,
                                        height: 20,
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 223, 220, 220)),
                              bottom: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 223, 220, 220)),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Email",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 73, 71, 71)),
                              ),
                              Row(
                                children: [
                                  Text(
                                    userSettingViewModel.email,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 73, 71, 71)),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SettingEmailPage()));
                                      },
                                      icon: Image.asset(
                                        "assets/images/next.png",
                                        width: 20,
                                        height: 20,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Text(
                  "Verified phone number and email help you secure your account",
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Discovery settings",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      )
                    ]),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 350,
                  child: ListView(
                    children: [
                      Container(
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 223, 220, 220)),
                              bottom: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 223, 220, 220)),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Location",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 73, 71, 71)),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Ha noi",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 73, 71, 71)),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        "assets/images/next.png",
                                        width: 20,
                                        height: 20,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 150,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 223, 220, 220)),
                              bottom: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 223, 220, 220)),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Distance preference",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 73, 71, 71)),
                                      ),
                                      Text(
                                        "${widget.currentRangeValues.end.round().toString()} km.",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 73, 71, 71)),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                      height: 50,
                                      child: RangeSlider(
                                        onChanged: (value) {},
                                        values: widget.currentRangeValues,
                                        max: 100,
                                        divisions: 5,
                                        labels: RangeLabels(
                                          widget.currentRangeValues.start
                                              .round()
                                              .toString(),
                                          widget.currentRangeValues.end
                                              .round()
                                              .toString(),
                                        ),
                                        onChangeEnd: (RangeValues values) {
                                          setState(() {
                                            widget.currentRangeValues = values;
                                          });
                                        },
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Only show people in this range",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 73, 71, 71)),
                                  ),
                                  CupertinoSwitch(
                                    activeColor: Colors.deepOrangeAccent,
                                    value: widget.isShowPeopleInDistance,
                                    onChanged: (value) => setState(() =>
                                        widget.isShowPeopleInDistance = value),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 150,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 223, 220, 220)),
                              bottom: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 223, 220, 220)),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Age preference",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 73, 71, 71)),
                                      ),
                                      Text(
                                        "${widget.currentRangeAgeValues.start.round().toString()} - ${widget.currentRangeAgeValues.end.round().toString()}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 73, 71, 71)),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                      height: 50,
                                      child: RangeSlider(
                                        onChanged: (value) {},
                                        values: widget.currentRangeAgeValues,
                                        max: 100,
                                        divisions: 5,
                                        labels: RangeLabels(
                                          widget.currentRangeAgeValues.start
                                              .round()
                                              .toString(),
                                          widget.currentRangeAgeValues.end
                                              .round()
                                              .toString(),
                                        ),
                                        onChangeEnd: (RangeValues values) {
                                          setState(() {
                                            widget.currentRangeAgeValues =
                                                values;
                                          });
                                        },
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Only show people in this range",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 73, 71, 71)),
                                  ),
                                  CupertinoSwitch(
                                    activeColor: Colors.deepOrangeAccent,
                                    value: widget.isShowPeopleInAge,
                                    onChanged: (value) => setState(
                                        () => widget.isShowPeopleInAge = value),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Verified phone number and email help you secure your account",
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Notifications",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      )
                    ]),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 100,
                  child: ListView(
                    children: [
                      Container(
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 223, 220, 220)),
                              bottom: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 223, 220, 220)),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Email",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 73, 71, 71)),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SettingEmailNotificationPage()),
                                    );
                                  },
                                  icon: Image.asset(
                                    "assets/images/next.png",
                                    width: 20,
                                    height: 20,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 223, 220, 220)),
                              bottom: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 223, 220, 220)),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Push notifications",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 73, 71, 71)),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SettingPushNotificationPage()),
                                    );
                                  },
                                  icon: Image.asset(
                                    "assets/images/next.png",
                                    width: 20,
                                    height: 20,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Appearance",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      )
                    ]),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 150,
                  child: ListView(
                    children: [
                      Container(
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 223, 220, 220)),
                              bottom: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 223, 220, 220)),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.selectedIndexAppearence = 0;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Use setting device",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 73, 71, 71)),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.check,
                                        color:
                                            widget.selectedIndexAppearence == 0
                                                ? Colors.deepOrangeAccent
                                                : Colors.white,
                                      ))
                                ],
                              )),
                        ),
                      ),
                      Container(
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 223, 220, 220)),
                              bottom: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 223, 220, 220)),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.selectedIndexAppearence = 1;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Light mode",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 73, 71, 71)),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.check,
                                        color:
                                            widget.selectedIndexAppearence == 1
                                                ? Colors.deepOrangeAccent
                                                : Colors.white,
                                      ))
                                ],
                              )),
                        ),
                      ),
                      Container(
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 223, 220, 220)),
                              bottom: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 223, 220, 220)),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.selectedIndexAppearence = 2;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Dark mode",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 73, 71, 71)),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.check,
                                        color:
                                            widget.selectedIndexAppearence == 2
                                                ? Colors.deepOrangeAccent
                                                : Colors.white,
                                      ))
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Display preference",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          )
                        ]),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView(
                        children: [
                          Container(
                            height: 50,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  top: BorderSide(
                                      width: 1.0,
                                      color:
                                          Color.fromARGB(255, 223, 220, 220)),
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color:
                                          Color.fromARGB(255, 223, 220, 220)),
                                )),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Language",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 73, 71, 71)),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        widget.locale,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 73, 71, 71)),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Image.asset(
                                            "assets/images/next.png",
                                            width: 20,
                                            height: 20,
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  top: BorderSide(
                                      width: 1.0,
                                      color:
                                          Color.fromARGB(255, 223, 220, 220)),
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color:
                                          Color.fromARGB(255, 223, 220, 220)),
                                )),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Show Distances in",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 73, 71, 71)),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        "assets/images/next.png",
                                        width: 20,
                                        height: 20,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                        width: 1.0, color: Color.fromARGB(255, 223, 220, 220)),
                    bottom: BorderSide(
                        width: 1.0, color: Color.fromARGB(255, 223, 220, 220)),
                  )),
              child: GestureDetector(
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                        'Hide my account',
                        textAlign: TextAlign.center,
                      ),
                      content: const Text(
                        'AlertDialog description AlertDialog description AlertDialog description AlertDialog description',
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        Column(
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text(
                                'OK',
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
                child: const Center(
                    child: Text(
                  "Delete Account",
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 73, 71, 71)),
                )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ]),
        ));
  }

  handleInitState() async {
    UserViewModel userViewModel =
        Provider.of<UserViewModel>(context, listen: false);
    UserSettingViewModel userSettingViewModel =
        Provider.of<UserSettingViewModel>(context, listen: false);

    if (userViewModel.isLoading || userSettingViewModel.isLoading) {
      return;
    }

    setState(() {
      userSettingViewModel.setSetting(userViewModel.user);
      widget.isShowPeopleInAge =
          userSettingViewModel.searchSetting!.is_only_show_in_age!;
      widget.isShowPeopleInDistance =
          userSettingViewModel.searchSetting!.is_only_show_in_distance!;
      widget.locale = userSettingViewModel.accountSetting!.language!;
      if (userSettingViewModel.searchSetting!.distance_preference != null) {
        widget.currentRangeValues = RangeValues(
            0,
            userSettingViewModel.searchSetting!.distance_preference!
                .toDouble());
      }
      if (userSettingViewModel.searchSetting!.min_age_preference != null &&
          userSettingViewModel.searchSetting!.max_age_preference != null) {
        widget.currentRangeAgeValues = RangeValues(
            userSettingViewModel.searchSetting!.min_age_preference!.toDouble(),
            userSettingViewModel.searchSetting!.max_age_preference!.toDouble());
      }
    });
  }

  handleSaveSetting(UserSettingViewModel userSettingViewModel,
      TokenViewModel tokenViewModel, UserViewModel userViewModel) async {
    userSettingViewModel.accountSetting!.language = widget.locale;
    userSettingViewModel.searchSetting!.is_only_show_in_age =
        widget.isShowPeopleInAge;
    userSettingViewModel.searchSetting!.distance_preference =
        widget.currentRangeValues.end.toInt();
    userSettingViewModel.searchSetting!.max_age_preference =
        widget.currentRangeAgeValues.end.toInt();
    userSettingViewModel.searchSetting!.min_age_preference =
        widget.currentRangeAgeValues.start.toInt();
    userSettingViewModel.searchSetting!.is_only_show_in_distance =
        widget.isShowPeopleInDistance;

    await userSettingViewModel.update(
        context, tokenViewModel.token.access_token);
    await userViewModel.getPersonalUserInfo(
        tokenViewModel.token.access_token, context);
  }

  @override
  void initState() {
    handleInitState();

    super.initState();
  }
}
