import 'package:flutter/material.dart';
import 'package:honey_mobile/viewmodels/user-setting.dart';
import 'package:provider/provider.dart';

class SettingEmailPage extends StatefulWidget {
  String email = "";

  SettingEmailPage({super.key});

  @override
  State<SettingEmailPage> createState() => _SettingEmailPageState();
}

class _SettingEmailPageState extends State<SettingEmailPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserSettingViewModel userSettingViewModel =
        Provider.of<UserSettingViewModel>(context);

    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          const Padding(
            padding: EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Set your email",
                    style: TextStyle(
                        color: Color.fromARGB(255, 12, 12, 12), fontSize: 25)),
              ],
            ),
          ),
          SizedBox(
            width: 300.0,
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                userSettingViewModel.email = _controller.text;
              },
              child: const Text('Save', style: TextStyle(fontSize: 20))),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {},
              child: const Text('Verify Mail', style: TextStyle(fontSize: 20)))
        ],
      ),
    ));
  }

  @override
  void initState() {
    UserSettingViewModel userSettingViewModel =
        Provider.of<UserSettingViewModel>(context, listen: false);

    setState(() {
      widget.email = userSettingViewModel.email;
      _controller.text = userSettingViewModel.email;
    });
    super.initState();
  }
}
