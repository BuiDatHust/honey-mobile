import 'package:flutter/material.dart';
import 'package:honey_mobile/pages/verify-otp.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class MySignIn extends StatefulWidget {
  const MySignIn({super.key});

  @override
  State<MySignIn> createState() => _MySigninState();
}

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MySignIn(),
    );
  }
}

class _MySigninState extends State<MySignIn> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Honey",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.w600,
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
                controller: controller,
                validator: (value) {
                  if (!value!.isValidNumber()) {
                    return 'Email is required';
                  }
                  return null;
                },
                flagsButtonPadding: const EdgeInsets.all(8),
                dropdownIconPosition: IconPosition.trailing,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'EN',
                onChanged: (phone) {
                  controller.text = phone.completeNumber;
                },
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VerifyOtpPage(
                              phnNumber: controller.text,
                              code: controller.text,
                            )),
                  );
                },
                child: const Text('Send OTP', style: TextStyle(fontSize: 20)))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controller.dispose();
    super.dispose();
  }
}
