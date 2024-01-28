import 'package:flutter/material.dart';
import 'package:honey_mobile/core/constants/user.dart';
import 'package:honey_mobile/viewmodels/onboard.dart';
import 'package:honey_mobile/widgets/custom-button.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class OnboardingPassion extends StatefulWidget {
  final TabController tabController;
  final Map<String, bool> selectedPassions = {};

  OnboardingPassion({
    super.key,
    required this.tabController,
  });

  @override
  State<OnboardingPassion> createState() => _OnboardPassionState();
}

class _OnboardPassionState extends State<OnboardingPassion> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    OnboardViewModel onboardViewModel = Provider.of<OnboardViewModel>(context);
    if (onboardViewModel.passions != null) {
      for (String p in onboardViewModel.passions as List<String>) {
        if (UserConstant.TITLES_PASSION[p] == null) {
          continue;
        }
        widget.selectedPassions[UserConstant.TITLES_PASSION[p] as String] =
            true;
      }
    }

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
                  List<String> passions = _getPassion();
                  if (passions.isEmpty) {
                    return;
                  }

                  onboardViewModel.passions = passions;
                  widget.tabController
                      .animateTo(widget.tabController.index - 1);
                },
              ),
              TextButton(
                child: const Text("Skip"),
                onPressed: () {
                  List<String> passions = _getPassion();
                  if (passions.isEmpty) {
                    return;
                  }

                  onboardViewModel.passions = passions;
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
                children: UserConstant.PASSION_TITLES.keys
                    .map((e) => ChoiceChip(
                          onSelected: (value) {
                            setState(() {
                              if (!value) {
                                widget.selectedPassions.remove(e);
                                return;
                              }

                              widget.selectedPassions[e] = value;
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
                          selected: widget.selectedPassions[e] ?? false,
                          elevation: 1,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ))
                    .toList(),
              )),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CheckboxListTile(
                    title: const Text("Show passion on my profile"),
                    value: onboardViewModel.is_show_passion ?? false,
                    onChanged: (val) {
                      onboardViewModel.setShowPassion(val ?? false);
                    }),
              )
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 10,
                currentStep: 5,
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).colorScheme.background,
              ),
              const SizedBox(height: 10),
              CustomButton(
                tabController: widget.tabController,
                text: 'NEXT STEP',
                callback: () {
                  List<String> passions = _getPassion();
                  if (passions.isEmpty) {
                    throw Error();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<String> _getPassion() {
    if (widget.selectedPassions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Passions is not empty"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 5),
      ));
      return [];
    }

    List<String> passions = [];
    for (String k in widget.selectedPassions.keys) {
      passions.add(UserConstant.PASSION_TITLES[k]!);
    }
    return passions;
  }
}
