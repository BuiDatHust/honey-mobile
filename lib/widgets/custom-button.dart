import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:honey_mobile/services/token.dart';
import 'package:honey_mobile/services/upload.dart';
import 'package:honey_mobile/services/user.dart';
import 'package:honey_mobile/viewmodels/onboard.dart';
import 'package:honey_mobile/viewmodels/token.dart';
import 'package:honey_mobile/viewmodels/user.dart';
import 'package:honey_mobile/views/authentication/signin.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;
  final String text;
  void Function()? callback;
  UploadService uploadService = UploadService();
  UserService userService = UserService();
  TokenService tokenService = TokenService();
  ConfettiController? centerController;

  CustomButton({
    Key? key,
    required this.tabController,
    required this.text,
    this.callback,
    this.centerController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OnboardViewModel onboardViewModel = Provider.of<OnboardViewModel>(context);
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    TokenViewModel tokenViewModel = Provider.of<TokenViewModel>(context);
    onboardViewModel.setService(uploadService, userService);
    userViewModel.setService(userService, tokenService);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).primaryColor,
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: () async {
          try {
            callback!();
            print(tabController.index);
            if (tabController.index != 9) {
              tabController.animateTo(tabController.index + 1);
              return;
            }

            bool isSuccess = await onboardViewModel.onboard(
                context, tokenViewModel.token.access_token);
            if (!isSuccess) {
              return;
            }

            // if (centerController != null) {
            //   centerController!.play();
            // }
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MySignIn()));
          } catch (e) {
            print("error1 $e");
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(e.toString()),
              backgroundColor: Theme.of(context).colorScheme.primary,
              duration: const Duration(seconds: 5),
            ));
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
