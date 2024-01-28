import 'package:flutter/material.dart';
import 'package:honey_mobile/viewmodels/edit-profile.dart';
import 'package:honey_mobile/viewmodels/token.dart';
import 'package:honey_mobile/viewmodels/user.dart';
import 'package:honey_mobile/views/edit-profile/edit-profile-page.dart';
import 'package:honey_mobile/views/edit-profile/preview-profile-page.dart';
import 'package:honey_mobile/widgets/circular-loading-widget.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    EditProfileViewModel editProfileViewModel =
        Provider.of<EditProfileViewModel>(context);
    TokenViewModel tokenViewModel = Provider.of<TokenViewModel>(context);
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);

    if (tokenViewModel.isLoading || editProfileViewModel.isLoading) {
      return CircularLoadingWidget();
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 199, 199, 199),
      appBar: null,
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1.0,
            actions: [
              TextButton(
                  onPressed: () async {
                    editProfileViewModel.setPhotoFile();
                    bool isSuccess = await editProfileViewModel.saveUserSetting(
                        context, tokenViewModel.token.access_token);
                    if (isSuccess) {
                      userViewModel.getPersonalUserInfo(
                          tokenViewModel.token.access_token, context);
                    }
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.deepOrangeAccent),
                  ))
            ],
            centerTitle: true,
            title: const Text(
              "Edit info",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(
                    icon: Text(
                  "Edit",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                )),
                Tab(
                    icon: Text(
                  "Preview",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                )),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              EditProfilePage(),
              PreviewProfile(),
            ],
          ),
        ),
      ),
    );
  }
}
