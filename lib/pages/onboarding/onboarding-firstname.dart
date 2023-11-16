import 'package:flutter/material.dart';
import 'package:honey_mobile/pages/welcome-onboard.dart';
import 'package:honey_mobile/widgets/custom-button.dart';
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
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                onPressed: () => {
                  widget.tabController.animateTo(widget.tabController.index + 1)
                },
              )
            ],
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My first",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Text(
                "name is",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(height: 12),
              SizedBox(
                width: 300.0,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'First name',
                  ),
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
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
                totalSteps: 6,
                currentStep: 1,
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).colorScheme.background,
              ),
              const SizedBox(height: 10),
              CustomButton(
                  tabController: widget.tabController, text: 'NEXT STEP'),
            ],
          ),
        ],
      ),
    );
  }
}
