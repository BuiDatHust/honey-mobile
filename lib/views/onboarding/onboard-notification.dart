import 'package:flutter/material.dart';
import 'package:honey_mobile/viewmodels/onboard.dart';
import 'package:honey_mobile/widgets/custom-button.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class OnboardingShowNotification extends StatefulWidget {
  final TabController tabController;

  const OnboardingShowNotification({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<OnboardingShowNotification> createState() => _OnboardGenderState();
}

class _OnboardGenderState extends State<OnboardingShowNotification> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    OnboardViewModel onboardViewModel = Provider.of<OnboardViewModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  widget.tabController
                      .animateTo(widget.tabController.index - 1);
                },
              ),
              TextButton(
                child: const Text("Skip"),
                onPressed: () {
                  widget.tabController
                      .animateTo(widget.tabController.index + 1);
                },
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.chat,
                size: 100,
              ),
              const Text(
                textAlign: TextAlign.center,
                "Keep me posted",
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
              const Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "You 'll need to enable location to dcdc dcdc",
                    style: TextStyle(color: Color.fromARGB(255, 148, 143, 143)),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () {
                    onboardViewModel.is_show_notification = true;
                    widget.tabController
                        .animateTo(widget.tabController.index + 1);
                  },
                  child: const Text(
                    "I WANT TO BE NOTIFIED",
                    style: TextStyle(fontSize: 15),
                  ))
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 10,
                currentStep: 7,
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).colorScheme.background,
              ),
              const SizedBox(height: 10),
              CustomButton(
                tabController: widget.tabController,
                text: 'NEXT STEP',
                callback: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
