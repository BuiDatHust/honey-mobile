import 'package:flutter/material.dart';
import 'package:honey_mobile/services/upload.dart';
import 'package:honey_mobile/services/user.dart';
import 'package:honey_mobile/viewmodels/onboard.dart';
import 'package:honey_mobile/views/welcome/welcome-onboard.dart';
import 'package:honey_mobile/widgets/custom-button.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class OnboardingFirstname extends StatefulWidget {
  final TabController tabController;

  const OnboardingFirstname({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<OnboardingFirstname> createState() => _OnboardFirstnameState();
}

class _OnboardFirstnameState extends State<OnboardingFirstname> {
  final TextEditingController _controller = TextEditingController();
  UploadService uploadService = UploadService();
  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    OnboardViewModel onboardViewModel = Provider.of<OnboardViewModel>(context);
    onboardViewModel.setService(uploadService, userService);
    _controller.text = onboardViewModel.first_name ?? "";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomeOnboardPage()),
                  )
                },
              ),
              TextButton(
                child: const Text("Skip"),
                onPressed: () {
                  bool isSuccess = _validateFirstname();

                  if (!isSuccess) {
                    return;
                  }
                  onboardViewModel.first_name = _controller.text;
                  widget.tabController
                      .animateTo(widget.tabController.index + 1);
                },
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "My first",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const Text(
                "name is",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 300.0,
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'First name',
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const SizedBox(
                width: 300.0,
                child: Text(
                  "This is how it will appear in Tinder, and you will not able to change it",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 10,
                currentStep: 1,
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).colorScheme.background,
              ),
              const SizedBox(height: 10),
              CustomButton(
                tabController: widget.tabController,
                text: 'NEXT STEP',
                callback: () {
                  bool isSuccess = _validateFirstname();
                  if (!isSuccess) {
                    throw Error();
                  }
                  onboardViewModel.first_name = _controller.text;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _validateFirstname() {
    if (_controller.text != "") {
      return true;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("First name is not empty"),
      backgroundColor: Theme.of(context).colorScheme.primary,
      duration: const Duration(seconds: 5),
    ));
    return false;
  }
}
