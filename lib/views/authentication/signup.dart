import 'package:flutter/material.dart';
import 'package:honey_mobile/core/constants/otp.dart';
import 'package:honey_mobile/services/otp.dart';
import 'package:honey_mobile/viewmodels/otp.dart';
import 'package:honey_mobile/views/authentication/signin.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  final OtpService otpService =
      OtpService(TYPE_OTP[PHONE]!, OTP_USECASE[REGISTER_ACCOUNT]!);
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String phoneNumber = "";
  String countryCode = "";

  @override
  Widget build(BuildContext context) {
    OtpViewModel otpViewModel = Provider.of<OtpViewModel>(context);
    otpViewModel.setService(widget.otpService);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/connect.png',
                  height: 25, width: 25, color: Theme.of(context).primaryColor),
              const SizedBox(width: 5),
              Text(
                "Honey",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
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
                  Text("Hey there,",
                      style: TextStyle(color: Colors.grey, fontSize: 20)),
                  Text(
                    "Please fill information to sign up!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 370,
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
                  phoneNumber = phone.number;
                  countryCode = phone.countryCode;
                },
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            otpViewModel.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      otpViewModel.sendSignUpOtp(
                          phoneNumber,
                          countryCode.substring(1),
                          'phone',
                          OTP_USECASE[REGISTER_ACCOUNT]!,
                          context);
                    },
                    child:
                        const Text('Send OTP', style: TextStyle(fontSize: 20))),
            otpViewModel.isLoading ? const Text("Loading") : const Text(""),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have account?"),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MySignIn()),
                      );
                    },
                    child:
                        const Text('Sign in', style: TextStyle(fontSize: 20)))
              ],
            )
          ],
        ),
      ),
    );
  }
}
