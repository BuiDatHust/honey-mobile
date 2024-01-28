import 'package:flutter/material.dart';
import 'package:honey_mobile/core/constants/user.dart';
import 'package:honey_mobile/viewmodels/edit-profile.dart';
import 'package:honey_mobile/widgets/circular-loading-widget.dart';
import 'package:provider/provider.dart';

class EditPassionPage extends StatefulWidget {
  final Map<String, bool> selectedPassions = {};

  EditPassionPage({
    super.key,
  });

  @override
  State<EditPassionPage> createState() => _OnboardPassionState();
}

class _OnboardPassionState extends State<EditPassionPage> {
  bool isShowPassion = false;

  @override
  Widget build(BuildContext context) {
    EditProfileViewModel editProfileViewModel =
        Provider.of<EditProfileViewModel>(context);

    if (editProfileViewModel.isLoading) {
      return CircularLoadingWidget();
    }

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Set your Passions",
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
                    value: isShowPassion,
                    onChanged: (val) {
                      setState(() {
                        isShowPassion = val!;
                      });
                    }),
              )
            ],
          ),
          ElevatedButton(
              onPressed: () {
                editProfileViewModel.handleSavePassion(
                    _getPassion(), isShowPassion, context);
              },
              child: const Text('Save', style: TextStyle(fontSize: 20)))
        ],
      ),
    ));
  }

  @override
  void initState() {
    EditProfileViewModel editProfileViewModel =
        Provider.of<EditProfileViewModel>(context, listen: false);

    isShowPassion = (editProfileViewModel.user!.visualization_fields ?? [])
            .contains('passions') ==
        false;
    if (editProfileViewModel.user!.passions != null) {
      for (String p in editProfileViewModel.user!.passions as List<String>) {
        if (UserConstant.TITLES_PASSION[p] == null) {
          continue;
        }
        widget.selectedPassions[UserConstant.TITLES_PASSION[p] as String] =
            true;
      }
    }
    super.initState();
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
