import 'package:flutter/material.dart';
import 'package:honey_mobile/core/constants/user.dart';
import 'package:honey_mobile/viewmodels/edit-profile.dart';
import 'package:provider/provider.dart';

class EditGenderPage extends StatefulWidget {
  String selectedGender = "";

  EditGenderPage({
    Key? key,
  }) : super(key: key);

  @override
  State<EditGenderPage> createState() => _OnboardGenderState();
}

class _OnboardGenderState extends State<EditGenderPage> {
  bool isShownGender = false;

  @override
  Widget build(BuildContext context) {
    EditProfileViewModel editProfileViewModel =
        Provider.of<EditProfileViewModel>(context);

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(height: 100),
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
                    value: isShownGender,
                    onChanged: (val) {
                      setState(() {
                        isShownGender = val!;
                      });
                    }),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    editProfileViewModel.handleSaveGender(
                        widget.selectedGender, isShownGender, context);
                  },
                  child: const Text('Save', style: TextStyle(fontSize: 20)))
            ],
          ),
        ],
      ),
    ));
  }

  @override
  void initState() {
    EditProfileViewModel editProfileViewModel =
        Provider.of<EditProfileViewModel>(context, listen: false);

    isShownGender = (editProfileViewModel.user!.visualization_fields ?? [])
            .contains('gender') ==
        false;
    widget.selectedGender =
        UserConstant.TITLES_GENDER[editProfileViewModel.user!.gender!]!;

    super.initState();
  }
}
