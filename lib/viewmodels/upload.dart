import 'dart:io';

import 'package:flutter/material.dart';
import 'package:honey_mobile/models/user/media.dart';
import 'package:honey_mobile/services/upload.dart';

class UploadViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<Media> medias = [];
  late UploadService uploadService;

  setService(UploadService uploadService) {
    this.uploadService = uploadService;
  }

  Future<void> uploadMedias(List<File> files, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      List<Media>? response = await uploadService.uploadMany(files);
      if (response == null) {
        return;
      }
      medias = response;
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 5),
      ));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
