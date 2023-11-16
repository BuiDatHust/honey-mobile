import 'package:flutter/material.dart';
import 'package:honey_mobile/widgets/custom-button.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

Widget _chip(String data, BuildContext context) => ChoiceChip(
      labelPadding: const EdgeInsets.all(2.0),
      label: Text(
        data,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.black, fontSize: 18),
      ),
      selectedColor: const Color.fromARGB(255, 247, 241, 246),
      selected: true,
      elevation: 1,
      padding: const EdgeInsets.symmetric(horizontal: 10),
    );

class OnboardingPassion extends StatefulWidget {
  final TabController tabController;

  const OnboardingPassion({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<OnboardingPassion> createState() => _OnboardPassionState();
}

class _OnboardPassionState extends State<OnboardingPassion> {
  final TextEditingController controller = TextEditingController();
  final List<String> passions = [
    'Coding',
    'Design',
    'Music',
    'Dancing',
    'Reading',
    'Cooking',
    'Traveling',
    'Photography',
    'Fashion',
    'Art',
    'Sports',
    'Gaming',
    'Fitness',
  ];
  bool _isChecked = false;

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
                "Passions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const Text(
                "Let anyone know what you're passionate about ,by editing it to your profile",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                  child: Wrap(
                spacing: 8,
                children: passions.map((e) => _chip(e, context)).toList(),
              )),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CheckboxListTile(
                    title: const Text("Show passion on my profile"),
                    value: _isChecked,
                    onChanged: (val) {
                      setState(() {
                        _isChecked = val!;
                      });
                    }),
              )
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 4,
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
