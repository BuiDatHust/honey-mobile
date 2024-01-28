import 'package:flutter/material.dart';
import 'package:honey_mobile/viewmodels/user-setting.dart';
import 'package:provider/provider.dart';

class SettingEmailNotificationPage extends StatefulWidget {
  bool isSendNewMatch = false;
  bool isSendNewMessage = false;

  SettingEmailNotificationPage({super.key});

  @override
  State<SettingEmailNotificationPage> createState() =>
      _SettingEmailNotificationPageState();
}

class _SettingEmailNotificationPageState
    extends State<SettingEmailNotificationPage> {
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
                Text("Set your email notification",
                    style: TextStyle(
                        color: Color.fromARGB(255, 12, 12, 12), fontSize: 25)),
              ],
            ),
          ),
          Column(
            children: [
              CheckboxListTile(
                  title: const Text("Send email notification about new match"),
                  value: widget.isSendNewMatch,
                  onChanged: (val) {
                    setState(() {
                      widget.isSendNewMatch = val!;
                    });
                  }),
              CheckboxListTile(
                  title:
                      const Text("Send email notification about new message"),
                  value: widget.isSendNewMessage,
                  onChanged: (val) {
                    setState(() {
                      widget.isSendNewMessage = val!;
                    });
                  }),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                userSettingViewModel.notificationSetting!.email_setting
                    .is_send_new_match = widget.isSendNewMatch;
                userSettingViewModel.notificationSetting!.email_setting
                    .is_send_new_message = widget.isSendNewMessage;
                Navigator.pop(context);
              },
              child: const Text('Save', style: TextStyle(fontSize: 20))),
        ],
      ),
    ));
  }

  @override
  void initState() {
    UserSettingViewModel userSettingViewModel =
        Provider.of<UserSettingViewModel>(context, listen: false);

    setState(() {
      widget.isSendNewMatch = userSettingViewModel
          .notificationSetting!.email_setting.is_send_new_match!;
      widget.isSendNewMessage = userSettingViewModel
          .notificationSetting!.email_setting.is_send_new_message!;
    });

    super.initState();
  }
}
