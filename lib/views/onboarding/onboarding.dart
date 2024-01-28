import 'package:flutter/material.dart';
import 'package:honey_mobile/views/onboarding/onboard-notification.dart';
import 'package:honey_mobile/views/onboarding/onboarding-dob.dart';
import 'package:honey_mobile/views/onboarding/onboarding-email.dart';
import 'package:honey_mobile/views/onboarding/onboarding-firstname.dart';
import 'package:honey_mobile/views/onboarding/onboarding-gender-show.dart';
import 'package:honey_mobile/views/onboarding/onboarding-gender.dart';
import 'package:honey_mobile/views/onboarding/onboarding-location.dart';
import 'package:honey_mobile/views/onboarding/onboarding-passion.dart';
import 'package:honey_mobile/views/onboarding/onboarding-photo.dart';
import 'package:honey_mobile/views/onboarding/onboarding-sex-orientation.dart';

class OnboardingScreen extends StatelessWidget {
  static const List<Tab> tabs = <Tab>[
    Tab(text: 'First name'),
    Tab(text: 'Demographics'),
    Tab(text: 'Demographics'),
    Tab(text: 'Demographics'),
    Tab(text: 'Demographics'),
    Tab(text: 'Demographics'),
    Tab(text: 'Demographics'),
    Tab(text: 'Demographics'),
    Tab(text: 'Demographics'),
    Tab(text: 'Demographics'),
  ];

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context);
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {}
        });
        return Scaffold(
          appBar: null,
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              OnboardingFirstname(tabController: tabController),
              OnboardingDob(tabController: tabController),
              OnboardingGender(tabController: tabController),
              OnboardingGenderShow(tabController: tabController),
              OnboardingPassion(tabController: tabController),
              OnboardingSexOrientation(tabController: tabController),
              OnboardingLocation(tabController: tabController),
              OnboardingShowNotification(tabController: tabController),
              OnboardingEmail(tabController: tabController),
              OnboardingPhoto(tabController: tabController),
            ],
          ),
        );
      }),
    );
  }
}
