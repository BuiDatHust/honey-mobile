import 'package:flutter/material.dart';
import 'package:honey_mobile/pages/welcome-onboard.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class VerifyOtpPage extends StatefulWidget {
  final String phnNumber;
  final String code;

  const VerifyOtpPage({Key? key, required this.phnNumber, required this.code})
      : super(key: key);

  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtpPage> {
  OtpFieldController otpController = OtpFieldController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        const SizedBox(
          height: 50,
        ),
        const Text(
          "Enter OTP",
          style: TextStyle(fontSize: 30),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          "Enter the OTP that was sent to ${widget.phnNumber}",
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 30,
        ),
        OTPTextField(
            controller: otpController,
            length: 5,
            width: MediaQuery.of(context).size.width,
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldWidth: 45,
            fieldStyle: FieldStyle.box,
            outlineBorderRadius: 15,
            style: const TextStyle(fontSize: 17),
            onChanged: (pin) {
              print("Changed: $pin");
            },
            onCompleted: (pin) {
              print("Completed: $pin");
            }),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const WelcomeOnboardPage()),
            );
          },
          child: const Text("Verify"),
        )
      ]),
    );
  }
}
