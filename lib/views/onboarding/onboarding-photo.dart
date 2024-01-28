import 'dart:io';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:honey_mobile/viewmodels/onboard.dart';
import 'package:honey_mobile/widgets/custom-button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:provider/provider.dart';
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
  bool _isChecked = false;
  Map<String, String> photoWithOrder = {};
  Map<String, File?> photoPendingUpload = {};
  ImagePicker imagePicker = ImagePicker();
  late ConfettiController _centerController;

  @override
  Widget build(BuildContext context) {
    OnboardViewModel onboardViewModel = Provider.of<OnboardViewModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _centerController,
              blastDirection: pi / 2,
              maxBlastForce: 5,
              minBlastForce: 1,
              emissionFrequency: 0.03,
              gravity: 0,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () => {
                      widget.tabController
                          .animateTo(widget.tabController.index - 1)
                    },
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Add photos",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      const Text(
                        "Hold, drag and drop to reorder",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      SizedBox(
                          height: 450,
                          child: GridView.count(
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            crossAxisCount: 3,
                            children: List.generate(9, (index) {
                              String order = "$index";
                              return _buildImageBox(order);
                            }),
                          )),
                      CheckboxListTile(
                          title: const Text("Use smart photo"),
                          value: _isChecked,
                          onChanged: (val) {
                            setState(() {
                              _isChecked = val!;
                            });
                          })
                    ],
                  ),
                )),
              ),
              Column(
                children: [
                  StepProgressIndicator(
                    totalSteps: 10,
                    currentStep: 10,
                    selectedColor: Theme.of(context).primaryColor,
                    unselectedColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    tabController: widget.tabController,
                    text: 'Done',
                    centerController: _centerController,
                    callback: () {
                      bool isSuccess = onboardViewModel.setPhotoFile(
                          context, photoPendingUpload);
                      if (!isSuccess) {
                        throw Error();
                      }
                    },
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // initialize confettiController
    _centerController =
        ConfettiController(duration: const Duration(seconds: 10));

    super.initState();
  }

  Widget _buildImageBox(String order) {
    Widget? child;
    IconData icon;
    if (photoWithOrder.containsKey(order) &&
        !photoPendingUpload.containsKey(order)) {
      child = Image.network(
        photoWithOrder[order]!,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fitWidth,
      );
    }
    if (photoPendingUpload.containsKey(order)) {
      child = Image.file(
        photoPendingUpload[order]!,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fitWidth,
      );
    }
    icon = child == null ? Icons.add : Icons.edit;

    return Center(
      child: Stack(
        children: [
          Container(
            height: 150,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
                border: DashedBorder.fromBorderSide(
                    dashLength: 10,
                    side: BorderSide(
                        color: Color.fromARGB(255, 197, 196, 196), width: 5)),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: child,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Stack(
              children: [
                Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        color: Colors.pinkAccent,
                        borderRadius: BorderRadius.circular(20)),
                    child: IconButton(
                      onPressed: () async {
                        _handleButtonEditImage(order);
                      },
                      icon: Icon(
                        size: 15,
                        icon,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleButtonEditImage(String order) async {
    XFile? image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      if (image == null) {
        return;
      }

      photoPendingUpload[order] = File(image.path);
    });
  }
}
