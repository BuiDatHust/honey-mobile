import 'package:dob_input_field/dob_input_field.dart';
import 'package:flutter/material.dart';
import 'package:honey_mobile/services/upload.dart';
import 'package:honey_mobile/services/user.dart';
import 'package:honey_mobile/viewmodels/onboard.dart';
import 'package:honey_mobile/widgets/custom-button.dart';
import 'package:provider/provider.dart';
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
  final _formKey = GlobalKey<FormState>();
  UploadService uploadService = UploadService();
  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    OnboardViewModel onboardViewModel = Provider.of<OnboardViewModel>(context);
    onboardViewModel.setService(uploadService, userService);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.93,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new),
                          onPressed: () {
                            bool isSuccess = _validateDob(false);
                            if (!isSuccess) {
                              return;
                            }

                            widget.tabController
                                .animateTo(widget.tabController.index - 1);
                          },
                        ),
                        TextButton(
                          child: const Text("Skip"),
                          onPressed: () {
                            bool isSuccess = _validateDob(false);
                            if (!isSuccess) {
                              return;
                            }

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
                          "My",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        const Text(
                          "birthday is",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: 300.0,
                          child: Form(
                              key: _formKey,
                              child: DOBInputField(
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                                dateFormatType: DateFormatType.MMDDYYYY,
                                showLabel: true,
                                showCursor: true,
                                initialDate: onboardViewModel.dob != null
                                    ? DateTime.fromMillisecondsSinceEpoch(
                                        onboardViewModel.dob as int)
                                    : null,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onDateSaved: (value) {
                                  print(value);
                                  onboardViewModel.dob =
                                      value.millisecondsSinceEpoch;
                                },
                              )),
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
                          totalSteps: 10,
                          currentStep: 2,
                          selectedColor: Theme.of(context).primaryColor,
                          unselectedColor:
                              Theme.of(context).colorScheme.background,
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          tabController: widget.tabController,
                          text: 'NEXT STEP',
                          callback: () {
                            _validateDob(true);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ))),
    );
  }

  bool _validateDob(bool isThrowError) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      return true;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Input invalid"),
      backgroundColor: Theme.of(context).colorScheme.primary,
      duration: const Duration(seconds: 5),
    ));
    if (isThrowError) {
      throw Error();
    }

    return false;
  }
}
