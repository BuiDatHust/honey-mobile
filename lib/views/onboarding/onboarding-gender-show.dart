import 'package:flutter/material.dart';
import 'package:honey_mobile/core/constants/user.dart';
import 'package:honey_mobile/viewmodels/onboard.dart';
import 'package:honey_mobile/widgets/custom-button.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class OnboardingGenderShow extends StatefulWidget {
  final TabController tabController;
  String selectedGender = "";

  OnboardingGenderShow({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<OnboardingGenderShow> createState() => _OnboardGenderState();
}

class _OnboardGenderState extends State<OnboardingGenderShow> {
  final TextEditingController controller = TextEditingController();
  final bool isChecked = false;

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
                  onboardViewModel.gender_show = widget.selectedGender;
                  widget.tabController
                      .animateTo(widget.tabController.index - 1);
                },
              ),
              TextButton(
                child: const Text("Skip"),
                onPressed: () {
                  if (widget.selectedGender == "") {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text("Gender show is not empty"),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      duration: const Duration(seconds: 5),
                    ));
                    return;
                  }

                  onboardViewModel.gender_show =
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
                "Gender show",
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
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 10,
                currentStep: 4,
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
                      content: const Text("Gender show is not empty"),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      duration: const Duration(seconds: 5),
                    ));
                    throw Error();
                  }

                  onboardViewModel.gender_show =
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
