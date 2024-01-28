import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:honey_mobile/core/constants/otp.dart';
import 'package:honey_mobile/firebase_options.dart';
import 'package:honey_mobile/services/otp.dart';
import 'package:honey_mobile/services/token.dart';
import 'package:honey_mobile/services/user.dart';
import 'package:honey_mobile/viewmodels/auth.dart';
import 'package:honey_mobile/viewmodels/chat-detail.dart';
import 'package:honey_mobile/viewmodels/chat-list.dart';
import 'package:honey_mobile/viewmodels/edit-profile.dart';
import 'package:honey_mobile/viewmodels/friend.dart';
import 'package:honey_mobile/viewmodels/home-page.dart';
import 'package:honey_mobile/viewmodels/message.dart';
import 'package:honey_mobile/viewmodels/mqtt-chat.dart';
import 'package:honey_mobile/viewmodels/mqtt.dart';
import 'package:honey_mobile/viewmodels/new-friend.dart';
import 'package:honey_mobile/viewmodels/onboard.dart';
import 'package:honey_mobile/viewmodels/otp.dart';
import 'package:honey_mobile/viewmodels/pending-reaction.dart';
import 'package:honey_mobile/viewmodels/token.dart';
import 'package:honey_mobile/viewmodels/user-setting.dart';
import 'package:honey_mobile/viewmodels/user.dart';
import 'package:honey_mobile/views/tabs/main-page.dart';
import 'package:honey_mobile/views/welcome/welcome-onboard.dart';
import 'package:honey_mobile/views/welcome/welcome.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runZonedGuarded(() async {
    runApp(const MyApp()); // starting point of app
  }, (error, stackTrace) {
    print("Error FROM OUT_SIDE FRAMEWORK ");
    print("--------------------------------");
    print("Error :  $error");
    print("StackTrace :  $stackTrace");
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OtpViewModel()),
        ChangeNotifierProvider(create: (_) => TokenViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => OnboardViewModel()),
        ChangeNotifierProvider(create: (_) => PendingReactionModel()),
        ChangeNotifierProvider(create: (_) => FriendViewModel()),
        ChangeNotifierProvider(create: (_) => NewFriendViewModel()),
        ChangeNotifierProvider(create: (_) => ChatListViewModel()),
        ChangeNotifierProvider(create: (_) => ChatDetailViewModel()),
        ChangeNotifierProvider(create: (_) => MQTTModel()),
        ChangeNotifierProvider(create: (_) => MessageViewModel()),
        ChangeNotifierProvider(create: (_) => MqttChatViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserSettingViewModel()),
        ChangeNotifierProvider(create: (_) => EditProfileViewModel()),
        ChangeNotifierProvider(create: (_) => HomePageViewModel())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.purple, primary: Colors.deepOrangeAccent),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> decodedToken = {};

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    TokenViewModel tokenViewModel = Provider.of<TokenViewModel>(context);

    if (userViewModel.isLoading || tokenViewModel.isTokenLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    print(decodedToken);
    if (tokenViewModel.token.access_token == "" ||
        (userViewModel.user == null && decodedToken['email'] != null)) {
      return const WelcomePage();
    }

    if (decodedToken.isNotEmpty && decodedToken['email'] == null) {
      return const WelcomeOnboardPage();
    }

    return const MainPage();
  }

  void handleInitState() async {
    UserViewModel userViewModel =
        Provider.of<UserViewModel>(context, listen: false);
    TokenViewModel tokenViewModel =
        Provider.of<TokenViewModel>(context, listen: false);
    userViewModel.setService(UserService(), TokenService());
    tokenViewModel.setService(
        OtpService(TYPE_OTP[PHONE]!, OTP_USECASE[MANUAL_LOGIN_ACCOUNT]!),
        TokenService());

    await tokenViewModel.setToken();
    decodedToken = JwtDecoder.decode(tokenViewModel.token.access_token);
    if (decodedToken['email'] != "") {
      userViewModel.getPersonalUserInfo(
          tokenViewModel.token.access_token, context);
    }
  }

  @override
  void initState() {
    super.initState();
    handleInitState();
  }
}
