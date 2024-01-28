import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:honey_mobile/core/constants/otp.dart';
import 'package:honey_mobile/services/otp.dart';
import 'package:honey_mobile/viewmodels/otp.dart';
import 'package:honey_mobile/views/authentication/signup.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class MySignIn extends StatefulWidget {
  final OtpService otpService =
      OtpService(TYPE_OTP[PHONE]!, OTP_USECASE[MANUAL_LOGIN_ACCOUNT]!);

  MySignIn({super.key});

  @override
  State<MySignIn> createState() => _MySigninState();
}

class _MySigninState extends State<MySignIn> {
  String phoneNumber = "";
  String countryCode = "";
  User? _currentUser;
  String _contactText = '';

  @override
  Widget build(BuildContext context) {
    OtpViewModel otpViewModel = Provider.of<OtpViewModel>(context);
    otpViewModel.setService(widget.otpService);
    final User? user = _currentUser;

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
                    "Welcome back!",
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
                      otpViewModel.sendLoginOtp(
                          phoneNumber,
                          countryCode.substring(1),
                          'phone',
                          'MANUAL_LOGIN_ACCOUNT',
                          context);
                    },
                    child:
                        const Text('Send OTP', style: TextStyle(fontSize: 20))),
            otpViewModel.isLoading ? const Text("Loading") : const Text(""),
            ElevatedButton(
                onPressed: _handleSignIn,
                child: const Text('Login with Google',
                    style: TextStyle(fontSize: 20))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Not Already have account?"),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                    child:
                        const Text('Sign up', style: TextStyle(fontSize: 20)))
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleGetContact(User user) async {
    setState(() {
      _contactText = user.email!;
    });
  }

  Future<void> _handleSignIn() async {
    try {
      final googleAccount = await GoogleSignIn().signIn();
      final googleAuth = await googleAccount?.authentication;
      print(googleAuth);
      final credentail = GoogleAuthProvider.credential(
          accessToken: googleAuth!.accessToken, idToken: googleAuth.idToken);
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credentail);
      print(userCredential);
      setState(() {
        _currentUser = userCredential.user;
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser!);
      }
    } catch (error) {
      print("error _handleSignIn");
      print(error);
    }
  }

  Map _handleSignOut() => {};

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }
}
