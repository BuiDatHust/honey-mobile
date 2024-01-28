import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honey_mobile/core/constants/user.dart';
import 'package:honey_mobile/models/user/media.dart';
import 'package:honey_mobile/viewmodels/edit-profile.dart';
import 'package:honey_mobile/viewmodels/token.dart';
import 'package:honey_mobile/viewmodels/user.dart';
import 'package:honey_mobile/views/edit-profile/edit-gender-page.dart';
import 'package:honey_mobile/views/edit-profile/edit-passions-page.dart';
import 'package:honey_mobile/views/edit-profile/edit-relationship-goal.dart';
import 'package:honey_mobile/views/edit-profile/edit-sex-orientation.dart';
import 'package:honey_mobile/widgets/circular-loading-widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController jobTitleInputController = TextEditingController();
  TextEditingController companyInputController = TextEditingController();
  TextEditingController aboutInputController = TextEditingController();
  Map<String, String> photoWithOrder = {};
  Map<String, File?> photoPendingUpload = {};
  bool isUseSmartPhoto = false;
  ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    EditProfileViewModel editProfileViewModel =
        Provider.of<EditProfileViewModel>(context);
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    TokenViewModel tokenViewModel = Provider.of<TokenViewModel>(context);

    var isLoading = userViewModel.isLoading ||
        tokenViewModel.isLoading ||
        editProfileViewModel.isLoading;

    List<String?> passions = editProfileViewModel.user!.passions!
        .map((e) => UserConstant.TITLES_PASSION[e])
        .toList();
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 240, 239, 239),
        appBar: null,
        body: isLoading
            ? CircularLoadingWidget()
            : SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: 450,
                      child: GridView.count(
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        crossAxisCount: 3,
                        children: List.generate(9, (index) {
                          String order = "$index";
                          return _buildImageBox(order, editProfileViewModel);
                        }),
                      )),
                  const Center(
                    child: Text("Add a video, pic or Loop to get 4% closer to"),
                  ),
                  const Center(
                    child: Text(
                        "completing your profile and you may even get more"),
                  ),
                  const Center(
                    child: Text("Likes."),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.pinkAccent),
                        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 40.0)),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Add media",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(
                              width: 1.0,
                              color: Color.fromARGB(255, 223, 220, 220)),
                          bottom: BorderSide(
                              width: 1.0,
                              color: Color.fromARGB(255, 223, 220, 220)),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Smart Photos",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 73, 71, 71)),
                          ),
                          CupertinoSwitch(
                            activeColor: Colors.deepOrangeAccent,
                            value: isUseSmartPhoto,
                            onChanged: (value) =>
                                setState(() => isUseSmartPhoto = value),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Smart Photos continuously test all your profile",
                    textAlign: TextAlign.start,
                  ),
                  const Text(
                    "photos and pick the best photo",
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "About BuiDat",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "22%",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.pinkAccent),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: aboutInputController,
                        minLines: 3,
                        onChanged: (value) {
                          editProfileViewModel.setBio(value);
                        },
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color:
                                        Color.fromARGB(255, 223, 220, 220)))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Do not include social media handles or other contact information contact information",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Passions",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 70,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  top: BorderSide(
                                      width: 1.0,
                                      color:
                                          Color.fromARGB(255, 223, 220, 220)),
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color:
                                          Color.fromARGB(255, 223, 220, 220)),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      passions.join(","),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color.fromARGB(255, 73, 71, 71)),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditPassionPage()),
                                        );
                                      },
                                      icon: Image.asset(
                                        "assets/images/next.png",
                                        width: 20,
                                        height: 20,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Relationship Goals",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "+2%",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pinkAccent),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  top: BorderSide(
                                      width: 1.0,
                                      color:
                                          Color.fromARGB(255, 223, 220, 220)),
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color:
                                          Color.fromARGB(255, 223, 220, 220)),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.remove_red_eye),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Looking for",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 73, 71, 71)),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        editProfileViewModel
                                                .user!.relationship_goal ??
                                            "",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 73, 71, 71)),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditRelationshipGoalPage()));
                                          },
                                          icon: Image.asset(
                                            "assets/images/next.png",
                                            width: 20,
                                            height: 20,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Gender",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ]),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 50,
                            child: ListView(
                              children: [
                                Container(
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        top: BorderSide(
                                            width: 1.0,
                                            color: Color.fromARGB(
                                                255, 223, 220, 220)),
                                        bottom: BorderSide(
                                            width: 1.0,
                                            color: Color.fromARGB(
                                                255, 223, 220, 220)),
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          editProfileViewModel.user!.gender!,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 73, 71, 71)),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditGenderPage()),
                                              );
                                            },
                                            icon: Image.asset(
                                              "assets/images/next.png",
                                              width: 20,
                                              height: 20,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Sexual Orientation",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ]),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 50,
                            child: ListView(
                              children: [
                                Container(
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        top: BorderSide(
                                            width: 1.0,
                                            color: Color.fromARGB(
                                                255, 223, 220, 220)),
                                        bottom: BorderSide(
                                            width: 1.0,
                                            color: Color.fromARGB(
                                                255, 223, 220, 220)),
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          editProfileViewModel
                                              .user!.sexual_orientation!,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 73, 71, 71)),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditSexOrientationPage()));
                                            },
                                            icon: Image.asset(
                                              "assets/images/next.png",
                                              width: 20,
                                              height: 20,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Languages I know",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "+2%",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pinkAccent),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  top: BorderSide(
                                      width: 1.0,
                                      color:
                                          Color.fromARGB(255, 223, 220, 220)),
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color:
                                          Color.fromARGB(255, 223, 220, 220)),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.language),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Add languages",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 73, 71, 71)),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Add",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 73, 71, 71)),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Image.asset(
                                            "assets/images/next.png",
                                            width: 20,
                                            height: 20,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Height",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "+3%",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pinkAccent),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  top: BorderSide(
                                      width: 1.0,
                                      color:
                                          Color.fromARGB(255, 223, 220, 220)),
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color:
                                          Color.fromARGB(255, 223, 220, 220)),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.language),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Add height",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 73, 71, 71)),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Add",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 73, 71, 71)),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Image.asset(
                                            "assets/images/next.png",
                                            width: 20,
                                            height: 20,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Job title",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "+3%",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pinkAccent),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  top: BorderSide(
                                      width: 1.0,
                                      color:
                                          Color.fromARGB(255, 223, 220, 220)),
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color:
                                          Color.fromARGB(255, 223, 220, 220)),
                                )),
                            child: TextFormField(
                              controller: jobTitleInputController,
                              onChanged: (value) {
                                editProfileViewModel.setJobTitle(value);
                              },
                              decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Add job title",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 223, 220, 220)))),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Company",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "+3%",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pinkAccent),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  top: BorderSide(
                                      width: 1.0,
                                      color:
                                          Color.fromARGB(255, 223, 220, 220)),
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color:
                                          Color.fromARGB(255, 223, 220, 220)),
                                )),
                            child: TextFormField(
                              onChanged: (value) {
                                editProfileViewModel.setCompany(value);
                              },
                              controller: companyInputController,
                              decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Add company",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 223, 220, 220)))),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ]),
              ));
  }

  @override
  void dispose() {
    jobTitleInputController.dispose();
    companyInputController.dispose();
    aboutInputController.dispose();

    super.dispose();
  }

  handleInitState() async {
    EditProfileViewModel editProfileViewModel =
        Provider.of<EditProfileViewModel>(context, listen: false);
    UserViewModel userViewModel =
        Provider.of<UserViewModel>(context, listen: false);

    if (userViewModel.isLoading || editProfileViewModel.isLoading) {
      return;
    }
    editProfileViewModel.setUser(userViewModel.user!);
    aboutInputController.text = userViewModel.user!.description ?? "";
    jobTitleInputController.text = userViewModel.user!.job_title ?? "";
    companyInputController.text = userViewModel.user!.company ?? "";
    for (int index = 0;
        index < editProfileViewModel.user!.medias!.length;
        index++) {
      Media media = editProfileViewModel.user!.medias![index]!;
      String order = index.toString();
      if (media.url == "") {
        continue;
      }
      photoWithOrder[order] = media.url!;
      editProfileViewModel.photoWithOrder = photoWithOrder;
    }
  }

  @override
  void initState() {
    handleInitState();
    super.initState();
  }

  Widget _buildImageBox(
      String order, EditProfileViewModel editProfileViewModel) {
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
                        _handleButtonEditImage(order, editProfileViewModel);
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

  void _handleButtonEditImage(
      String order, EditProfileViewModel editProfileViewModel) async {
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
    editProfileViewModel.photoPendingUpload = photoPendingUpload;
  }
}
