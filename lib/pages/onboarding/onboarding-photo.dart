import 'package:flutter/material.dart';
import 'package:honey_mobile/widgets/custom-button.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class OnboardingPhoto extends StatefulWidget {
  final TabController tabController;

  const OnboardingPhoto({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<OnboardingPhoto> createState() => _OnboardPhotoState();
}

class _OnboardPhotoState extends State<OnboardingPhoto> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                onPressed: () => {
                  widget.tabController.animateTo(widget.tabController.index - 1)
                },
              ),
            ],
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Add photos",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Text(
                "Hold, drag and drop to reorder",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 6,
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).colorScheme.background,
              ),
              const SizedBox(height: 10),
              CustomButton(tabController: widget.tabController, text: 'Done'),
            ],
          ),
        ],
      ),
    );
  }
}
