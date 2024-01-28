import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:honey_mobile/models/user/media.dart';
import 'package:honey_mobile/services/upload.dart';
import 'package:honey_mobile/services/user.dart';

class OnboardViewModel extends ChangeNotifier {
  String? first_name;
  int? dob;
  String? sexual_orientation;
  String? gender;
  String? gender_show;
  List<String>? passions;
  List<File?>? files;
  List<String> visualization_fields = [];
  bool? is_show_notification;
  bool? is_show_location;
  List<double>? location;
  bool is_show_gender = true;
  bool is_show_passion = true;
  bool is_show_sex_orientation = true;
  String? email;

  bool isLoading = false;

  UploadService? uploadService;
  UserService? userService;

  Future<bool> onboard(BuildContext context, String accessToken) async {
    isLoading = true;
    notifyListeners();
    visualization_fields = [];
    if (!is_show_gender) {
      visualization_fields.add('gender');
    }
    if (!is_show_sex_orientation) {
      visualization_fields.add('sexual_orientation');
    }
    if (!is_show_passion) {
      visualization_fields.add('passions');
    }
    Map<String, dynamic> body = {
      "first_name": first_name,
      "email": email,
      "dob": dob,
      "sexual_orientation": sexual_orientation,
      "gender": gender,
      "gender_show": gender_show,
      "passions": passions ?? ["K_POP", "POP"],
      "hide_fields": visualization_fields,
      "is_show_notification": is_show_notification == null ? false : true,
      "location": location,
    };

    try {
      if (files != null) {
        List<Media>? medias =
            await UploadService().uploadMany(files as List<File?>);
        body["medias"] = medias;
      }

      await userService!.onboard(accessToken, body);

      return true;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> requestLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition();
    location = [position.longitude, position.latitude];
  }

  bool setPhotoFile(
      BuildContext context, Map<String, File?> photoPendingUpload) {
    if (photoPendingUpload.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Media must greated than 3"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 5),
      ));
      return false;
    }
    List<File?> pendingUploadFiles = [
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
    for (MapEntry<String, File?> entry in photoPendingUpload.entries) {
      if (entry.value == null) {
        continue;
      }

      pendingUploadFiles[int.parse(entry.key)] = entry.value;
    }

    files = pendingUploadFiles;

    return true;
  }

  setService(UploadService uploadService, UserService userService) {
    this.userService = userService;
    this.uploadService = uploadService;
  }

  void setShowGender(bool value) {
    is_show_gender = value;
    notifyListeners();
  }

  void setShowPassion(bool value) {
    is_show_passion = value;
    notifyListeners();
  }

  void setShowSexOrientation(bool value) {
    is_show_sex_orientation = value;
    notifyListeners();
  }
}
