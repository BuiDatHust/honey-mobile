import 'package:flutter/material.dart';
import 'package:honey_mobile/viewmodels/user-setting.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class SettingPhonePage extends StatefulWidget {
  String phoneNumber = "";
  String countryCode = "";

  SettingPhonePage({super.key});

  @override
  State<SettingPhonePage> createState() => _SettingPhonePageState();
}

class _SettingPhonePageState extends State<SettingPhonePage> {
  @override
  Widget build(BuildContext context) {
    UserSettingViewModel userSettingViewModel =
        Provider.of<UserSettingViewModel>(context);

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          const Padding(
            padding: EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Set your phone",
                    style: TextStyle(
                        color: Color.fromARGB(255, 12, 12, 12), fontSize: 25)),
              ],
            ),
          ),
          Center(
            child: SizedBox(
              width: 300,
              child: IntlPhoneField(
                flagsButtonPadding: const EdgeInsets.all(8),
                dropdownIconPosition: IconPosition.trailing,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'EN',
                onCountryChanged: (value) => {},
                onChanged: (phone) {
                  widget.phoneNumber = phone.number;
                  widget.countryCode = phone.countryCode;
                },
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                userSettingViewModel.countryCode = widget.countryCode;
                userSettingViewModel.phoneNumber = widget.phoneNumber;
                Navigator.pop(context);
              },
              child: const Text('Save', style: TextStyle(fontSize: 20)))
        ],
      ),
    );
  }

  @override
  void initState() {
    UserSettingViewModel userSettingViewModel =
        Provider.of<UserSettingViewModel>(context, listen: false);

    setState(() {
      widget.phoneNumber = userSettingViewModel.phoneNumber;
      widget.countryCode = userSettingViewModel.countryCode;
    });
    super.initState();
  }
}
