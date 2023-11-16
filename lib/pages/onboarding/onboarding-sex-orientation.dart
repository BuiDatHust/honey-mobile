import 'package:flutter/material.dart';
import 'package:honey_mobile/widgets/custom-button.dart';
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
  final List<String> sexOrientations = [
    "Straight",
    "Gay",
    "Lesbian",
    "Bisexual",
    "Asexual",
    // "Demisexual",
    // "Pansexual"
  ];
  Map<int, bool> selectedFlag = {};
  bool isSelectionMode = true;
  bool _isChecked = false;

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
                  String data = sexOrientations[index];
                  selectedFlag[index] = selectedFlag[index] ?? false;
                  bool isSelected = selectedFlag[index]!;

                  return ListTile(
                    onLongPress: () => onLongPress(isSelected, index),
                    onTap: () => onTap(isSelected, index),
                    title: Text(data),
                    leading: Icon(
                      isSelected
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: Theme.of(context).primaryColor,
                    ), // updated
                  );
                },
                itemCount: sexOrientations.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CheckboxListTile(
                    title: const Text("Show my orientation on my profile"),
                    value: _isChecked,
                    onChanged: (val) {
                      setState(() {
                        _isChecked = val!;
                      });
                    }),
              )
            ],
          )),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 5,
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

  void onLongPress(bool isSelected, int index) {
    setState(() {
      selectedFlag[index] = !isSelected;
      isSelectionMode = selectedFlag.containsValue(true);
    });
  }

  void onTap(bool isSelected, int index) {
    if (isSelectionMode) {
      setState(() {
        selectedFlag[index] = !isSelected;
        isSelectionMode = selectedFlag.containsValue(true);
      });
    }
  }
}
