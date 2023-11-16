import 'package:dob_input_field/dob_input_field.dart';
import 'package:flutter/material.dart';
import 'package:honey_mobile/widgets/custom-button.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class OnboardingDob extends StatefulWidget {
  final TabController tabController;

  const OnboardingDob({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<OnboardingDob> createState() => _OnboardDobState();
}

class _OnboardDobState extends State<OnboardingDob> {
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
                  widget.tabController.animateTo(widget.tabController.index - 1)
                },
              ),
              TextButton(
                child: const Text("Skip"),
                onPressed: () => {
                  widget.tabController.animateTo(widget.tabController.index + 1)
                },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "My",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const Text(
                "birthday is",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 300.0,
                child: DOBInputField(
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  showLabel: true,
                  showCursor: true,
                  autovalidateMode: AutovalidateMode.always,
                ),
              ),
              const SizedBox(height: 5),
              const SizedBox(
                width: 300.0,
                child: Text(
                  "Your age will be public",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 2,
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
