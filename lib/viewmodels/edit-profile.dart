import 'dart:io';

import 'package:flutter/material.dart';
import 'package:honey_mobile/core/constants/user.dart';
import 'package:honey_mobile/models/user/media.dart';
import 'package:honey_mobile/models/user/users.dart';
import 'package:honey_mobile/services/upload.dart';
import 'package:honey_mobile/services/user.dart';

class EditProfileViewModel extends ChangeNotifier {
  bool isLoading = false;
  User? user;
  UserService userService = UserService();
  Map<String, String> photoWithOrder = {};
  Map<String, File?> photoPendingUpload = {};
  List<dynamic> files = [];

  handleSaveGender(String gender, bool isShownGender, BuildContext context) {
    user!.gender = UserConstant.GENDER_TITLES[gender];
    if (!isShownGender) {
      (user!.visualization_fields ?? []).add('passions');
    }
    notifyListeners();
    Navigator.pop(context);
  }

  handleSavePassion(
      List<String> passions, bool isShowPassion, BuildContext context) {
    user!.passions = passions;
    if (!isShowPassion) {
      (user!.visualization_fields ?? []).add('gender');
    }
    notifyListeners();
    Navigator.pop(context);
  }

  handleSaveRelationshipGoal(int index, bool isShow, BuildContext context) {
    user!.relationship_goal = UserConstant.RELATIONSHIP_GOALS[index];
    if (!isShow) {
      (user!.visualization_fields ?? []).add('relationship_goal');
    }

    notifyListeners();
    Navigator.pop(context);
  }

  handleSaveSexOrientation(int index, bool isShow, BuildContext context) {
    user!.sexual_orientation = UserConstant
        .SEXUAL_ORIENTATION[UserConstant.SEXUAL_ORIENTATIONS[index]];
    if (!isShow) {
      (user!.visualization_fields ?? []).add('sex_orientation');
    }

    notifyListeners();
    Navigator.pop(context);
  }

  saveUserSetting(BuildContext context, String accessToken) async {
    isLoading = true;
    notifyListeners();
    Map<String, dynamic> body = {
      'first_name': user!.firstname,
      'dob': user!.dob,
      'sexual_orientation': user!.sexual_orientation,
      'relationship_goal': user!.relationship_goal,
      'gender': user!.gender,
      'passions': user!.passions,
      'medias': user!.medias,
      'hide_fields': user!.visualization_fields ?? [],
      'company': user!.company,
      'job_title': user!.job_title,
      'address': user!.address,
      'coordinates': user!.coordinates,
    };
    body['hide_fields'] = user!.visualization_fields ?? [];

    try {
      List<Media>? medias = await UploadService().uploadMany(files);
      body["medias"] = medias;

      print(body);
      await userService.updateProfile(accessToken, body);
      return true;
    } catch (e) {
      print("update saveUserSetting $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  setBio(String bio) {
    user!.description = bio;
    notifyListeners();
  }

  setCompany(String company) {
    user!.company = company;
    notifyListeners();
  }

  setJobTitle(String jobtitle) {
    user!.job_title = jobtitle;
    notifyListeners();
  }

  bool setPhotoFile() {
    List<dynamic> pendingUploadFiles = [
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
    ];
    for (MapEntry<String, String> entry in photoWithOrder.entries) {
      pendingUploadFiles[int.parse(entry.key)] = entry.value;
    }
    for (MapEntry<String, File?> entry in photoPendingUpload.entries) {
      if (entry.value == null) {
        continue;
      }

      pendingUploadFiles[int.parse(entry.key)] = entry.value;
    }
    files = pendingUploadFiles;

    return true;
  }

  setUser(User newUser) {
    user = newUser;
    notifyListeners();
  }

  Future<void> update(BuildContext context, String accessToken) async {
    try {
      isLoading = true;
      notifyListeners();

      Map<String, dynamic> body = user as Map<String, dynamic>;
      await userService.updateProfile(accessToken, body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Success update profile!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 5),
      ));
    } catch (e) {
      print("error update profile $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Fail to update profile!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 5),
      ));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
