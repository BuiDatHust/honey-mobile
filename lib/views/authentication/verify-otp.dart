import 'package:flutter/material.dart';
import 'package:honey_mobile/core/constants/otp.dart';
import 'package:honey_mobile/services/otp.dart';
import 'package:honey_mobile/services/token.dart';
import 'package:honey_mobile/viewmodels/otp.dart';
import 'package:honey_mobile/viewmodels/token.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

class VerifyOtpPage extends StatefulWidget {
  final OtpService otpService =
      OtpService(TYPE_OTP[PHONE]!, OTP_USECASE[MANUAL_LOGIN_ACCOUNT]!);
  final TokenService tokenService = TokenService();
  final String phnNumber;
  final String countryCode;
  final String typeOtp;
  final String otpUsecase;

  
  
  
  VerifyOtpPage(
      {super.key,
      required this.phnNumber,
      required this.countryCode,
      required this.typeOtp,
      required this.otpUsecase});

  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtpPage> {
  String code = "";

  @override
  Widget build(BuildContext context) {
    OtpViewModel otpViewModel = Provider.of<OtpViewModel>(context);
    TokenViewModel tokenViewModel = Provider.of<TokenViewModel>(context);
    otpViewModel.setService(widget.otpService);
    tokenViewModel.setService(widget.otpService, widget.tokenService);

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
            length: 6,
            width: MediaQuery.of(context).size.width,
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldWidth: 45,
            fieldStyle: FieldStyle.box,
            outlineBorderRadius: 15,
            style: const TextStyle(fontSize: 17),
            onChanged: (pin) {},
            onCompleted: (pin) {
              code = pin;
            }),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Dont recieved OTP?",
              style: TextStyle(color: Color.fromARGB(255, 66, 63, 63)),
            ),
            TextButton(
                onPressed: () {
                  otpViewModel.resendLoginOtp(
                      widget.phnNumber,
                      widget.countryCode,
                      widget.typeOtp,
                      widget.otpUsecase,
                      context);
                },
                child: const Text(
                  "Resend OTP",
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () async {
            await tokenViewModel.requestLocation();
            tokenViewModel.verifyLoginOtp(widget.phnNumber, widget.countryCode,
                widget.typeOtp, widget.otpUsecase, code, context);
          },
          child: tokenViewModel.isLoading == false
              ? const Text("Verify")
              : const CircularProgressIndicator(),
        )
      ]),
    );
  }
}
