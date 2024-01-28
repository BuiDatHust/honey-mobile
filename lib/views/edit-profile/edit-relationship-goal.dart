import 'package:flutter/material.dart';
import 'package:honey_mobile/core/constants/user.dart';
import 'package:honey_mobile/viewmodels/edit-profile.dart';
import 'package:provider/provider.dart';

class EditRelationshipGoalPage extends StatefulWidget {
  int selectedIndex = 0;
  bool isShow = false;
  EditRelationshipGoalPage({
    Key? key,
  }) : super(key: key);

  @override
  State<EditRelationshipGoalPage> createState() =>
      _OnboardSexOrientationState();
}

class _OnboardSexOrientationState extends State<EditRelationshipGoalPage> {
  @override
  Widget build(BuildContext context) {
    EditProfileViewModel editProfileViewModel =
        Provider.of<EditProfileViewModel>(context);

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Expanded(
              child: Column(
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
              SizedBox(
                height: 300,
                child: SingleChildScrollView(
                  child: ListView.builder(
                    itemBuilder: (builder, index) {
                      String data = UserConstant.RELATIONSHIP_GOALS[index];
                      bool isSelected = widget.selectedIndex == index;

                      return ListTile(
                        onTap: () => onTap(editProfileViewModel, index),
                        title: Text(data),
                        leading: Icon(
                          isSelected
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: Theme.of(context).primaryColor,
                        ), // updated
                      );
                    },
                    itemCount: UserConstant.RELATIONSHIP_GOALS.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CheckboxListTile(
                    title: const Text("Show my orientation on my profile"),
                    value: widget.isShow,
                    onChanged: (val) {
                      setState(() {
                        widget.isShow = val!;
                      });
                    }),
              ),
              ElevatedButton(
                  onPressed: () {
                    editProfileViewModel.handleSaveRelationshipGoal(
                        widget.selectedIndex, widget.isShow, context);
                  },
                  child: const Text('Save', style: TextStyle(fontSize: 20)))
            ],
          )),
        ],
      ),
    ));
  }

  @override
  void initState() {
    EditProfileViewModel editProfileViewModel =
        Provider.of<EditProfileViewModel>(context, listen: false);

    widget.isShow = (editProfileViewModel.user!.visualization_fields ?? [])
            .contains('sex_orientation') ==
        false;
    widget.selectedIndex = (editProfileViewModel.user!.relationship_goal != null
        ? UserConstant.RELATIONSHIP_GOALS
            .indexOf(editProfileViewModel.user!.relationship_goal ?? "")
        : 0);

    super.initState();
  }

  void onTap(EditProfileViewModel onboardViewModel, int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }
}
