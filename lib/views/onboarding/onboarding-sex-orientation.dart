import 'package:flutter/material.dart';
import 'package:honey_mobile/core/constants/user.dart';
import 'package:honey_mobile/viewmodels/onboard.dart';
import 'package:honey_mobile/widgets/custom-button.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class OnboardingSexOrientation extends StatefulWidget {
  final TabController tabController;

  const OnboardingSexOrientation({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<OnboardingSexOrientation> createState() =>
      _OnboardSexOrientationState();
}

class _OnboardSexOrientationState extends State<OnboardingSexOrientation> {
  final TextEditingController controller = TextEditingController();
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    OnboardViewModel onboardViewModel = Provider.of<OnboardViewModel>(context);
    selectedIndex = onboardViewModel.sexual_orientation != null
        ? UserConstant.SEXUAL_ORIENTATIONS.indexOf(UserConstant
            .ORIENTATION_SEXUAL[onboardViewModel.sexual_orientation] as String)
        : null;

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
                onPressed: () {
                  widget.tabController
                      .animateTo(widget.tabController.index - 1);
                },
              ),
              TextButton(
                child: const Text("Skip"),
                onPressed: () {
                  if (selectedIndex == null) {
                    return;
                  }

                  widget.tabController
                      .animateTo(widget.tabController.index + 1);
                },
              ),
            ],
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My sexual",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Text(
                    "orientation is",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  )
                ],
              ),
              const SizedBox(height: 12),
              ListView.builder(
                itemBuilder: (builder, index) {
                  String data = UserConstant.SEXUAL_ORIENTATIONS[index];
                  bool isSelected = selectedIndex == index;

                  return ListTile(
                    onTap: () => onTap(onboardViewModel, index),
                    title: Text(data),
                    leading: Icon(
                      isSelected
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: Theme.of(context).primaryColor,
                    ), // updated
                  );
                },
                itemCount: UserConstant.SEXUAL_ORIENTATIONS.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CheckboxListTile(
                    title: const Text("Show my orientation on my profile"),
                    value: onboardViewModel.is_show_sex_orientation ?? false,
                    onChanged: (val) {
                      onboardViewModel.setShowSexOrientation(val ?? false);
                    }),
              )
            ],
          )),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 10,
                currentStep: 6,
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).colorScheme.background,
              ),
              const SizedBox(height: 10),
              CustomButton(
                tabController: widget.tabController,
                text: 'NEXT STEP',
                callback: () {
                  if (selectedIndex == null) {
                    throw Error();
                  }
                  onboardViewModel.sexual_orientation = UserConstant
                          .SEXUAL_ORIENTATION[
                      UserConstant.SEXUAL_ORIENTATIONS[selectedIndex as int]];
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onTap(OnboardViewModel onboardViewModel, int index) {
    setState(() {
      selectedIndex = index;
    });
    onboardViewModel.sexual_orientation = UserConstant
        .SEXUAL_ORIENTATION[UserConstant.SEXUAL_ORIENTATIONS[index]];
  }
}
