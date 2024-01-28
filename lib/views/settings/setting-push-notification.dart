import 'package:flutter/material.dart';
import 'package:honey_mobile/viewmodels/user-setting.dart';
import 'package:provider/provider.dart';

class SettingPushNotificationPage extends StatefulWidget {
  bool isSendNewMatch = false;
  bool isSendNewMessage = false;
  bool isSendNewLike = false;

  SettingPushNotificationPage({super.key});

  @override
  State<SettingPushNotificationPage> createState() =>
      _SettingPushNotificationPageState();
}

class _SettingPushNotificationPageState
    extends State<SettingPushNotificationPage> {
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
                Text("Set your push notification",
                    style: TextStyle(
                        color: Color.fromARGB(255, 12, 12, 12), fontSize: 25)),
              ],
            ),
          ),
          Column(
            children: [
              CheckboxListTile(
                  title: const Text("Push notification about new match"),
                  value: widget.isSendNewMatch,
                  onChanged: (val) {
                    setState(() {
                      widget.isSendNewMatch = val!;
                    });
                  }),
              CheckboxListTile(
                  title: const Text("Push notification about new message"),
                  value: widget.isSendNewMessage,
                  onChanged: (val) {
                    setState(() {
                      widget.isSendNewMessage = val!;
                    });
                  }),
              CheckboxListTile(
                  title: const Text("Push notification about new like"),
                  value: widget.isSendNewLike,
                  onChanged: (val) {
                    setState(() {
                      widget.isSendNewLike = val!;
                    });
                  }),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                userSettingViewModel
                    .notificationSetting!
                    .push_notification_setting
                    .is_send_new_match = widget.isSendNewMatch;
                userSettingViewModel
                    .notificationSetting!
                    .push_notification_setting
                    .is_send_new_message = widget.isSendNewMessage;
                userSettingViewModel
                    .notificationSetting!
                    .push_notification_setting
                    .is_send_message_like = widget.isSendNewLike;
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
          .notificationSetting!.push_notification_setting.is_send_new_match!;
      widget.isSendNewMessage = userSettingViewModel
          .notificationSetting!.push_notification_setting.is_send_new_message!;
      widget.isSendNewLike = userSettingViewModel
          .notificationSetting!.push_notification_setting.is_send_message_like!;
    });

    super.initState();
  }
}
