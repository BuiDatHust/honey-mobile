import 'package:flutter/material.dart';
import 'package:honey_mobile/core/constants/user.dart';
import 'package:honey_mobile/viewmodels/onboard.dart';
import 'package:honey_mobile/widgets/custom-button.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class OnboardingGender extends StatefulWidget {
  final TabController tabController;
  String selectedGender = "";

  OnboardingGender({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<OnboardingGender> createState() => _OnboardGenderState();
}

class _OnboardGenderState extends State<OnboardingGender> {
  final TextEditingController controller = TextEditingController();
  int? selectedIndex;

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
                  onboardViewModel.gender =
                      UserConstant.GENDER_TITLES[widget.selectedGender];
                  widget.tabController
                      .animateTo(widget.tabController.index - 1);
                },
              ),
              TextButton(
                child: const Text("Skip"),
                onPressed: () {
                  if (widget.selectedGender == "") {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text("Gender is not empty"),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      duration: const Duration(seconds: 5),
                    ));
                    return;
                  }

                  onboardViewModel.gender =
                      UserConstant.GENDER_TITLES[widget.selectedGender];
                  widget.tabController
                      .animateTo(widget.tabController.index + 1);
                },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "I am a",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                  child: Wrap(
                spacing: 8,
                children: UserConstant.GENDER_TITLES.keys
                    .map((e) => ChoiceChip(
                          onSelected: (value) {
                            setState(() {
                              widget.selectedGender = e;
                            });
                          },
                          labelPadding: const EdgeInsets.all(2.0),
                          label: Text(
                            e,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.black, fontSize: 18),
                          ),
                          selectedColor:
                              const Color.fromARGB(255, 173, 127, 166),
                          disabledColor:
                              const Color.fromARGB(255, 247, 241, 246),
                          selected: widget.selectedGender == e ? true : false,
                          elevation: 1,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ))
                    .toList(),
              )),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CheckboxListTile(
                    title: const Text("Show gender on my profile"),
                    value: onboardViewModel.is_show_gender ?? false,
                    onChanged: (val) {
                      onboardViewModel.setShowGender(val ?? false);
                    }),
              )
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 10,
                currentStep: 3,
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).colorScheme.background,
              ),
              const SizedBox(height: 10),
              CustomButton(
                tabController: widget.tabController,
                text: 'NEXT STEP',
                callback: () {
                  if (widget.selectedGender == "") {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text("Gender is not empty"),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      duration: const Duration(seconds: 5),
                    ));
                    throw Error();
                  }

                  onboardViewModel.gender =
                      UserConstant.GENDER_TITLES[widget.selectedGender];
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
