import 'dart:io';

import 'package:flutter/material.dart';
import 'package:honey_mobile/viewmodels/edit-profile.dart';
import 'package:provider/provider.dart';

class PreviewProfile extends StatefulWidget {
  List<dynamic> tempMedias = [];
  PreviewProfile({super.key});

  @override
  State<PreviewProfile> createState() => _PreviewProfileState();
}

class _PreviewProfileState extends State<PreviewProfile> {
  int indexMedia = 0;

  @override
  Widget build(BuildContext context) {
    EditProfileViewModel editProfileViewModel =
        Provider.of<EditProfileViewModel>(context);
    Size size = MediaQuery.of(context).size;
    String firstname = editProfileViewModel.user!.firstname ?? "bui dat";
    String age = editProfileViewModel.user!.age.toString();

    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                  child: GestureDetector(
                onTapDown: (details) {
                  if (details.localPosition.dx >
                          MediaQuery.of(context).size.width / 2 &&
                      indexMedia < widget.tempMedias.length - 1) {
                    setState(() {
                      indexMedia++;
                    });
                  }

                  if (details.localPosition.dx <=
                          MediaQuery.of(context).size.width / 2 &&
                      indexMedia > 0) {
                    setState(() {
                      indexMedia--;
                    });
                  }
                },
                child: Container(
                  height: size.height * 0.6,
                  decoration: BoxDecoration(
                    image: widget.tempMedias[indexMedia].runtimeType == String
                        ? DecorationImage(
                            image: NetworkImage(widget.tempMedias[indexMedia]),
                            fit: BoxFit.cover)
                        : null,
                  ),
                  child: widget.tempMedias[indexMedia].runtimeType == File
                      ? Image.file(
                          widget.tempMedias[indexMedia]!,
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                        )
                      : null,
                ),
              )),
              Positioned(
                  top: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        widget.tempMedias.length,
                        (index) => Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 4,
                                width: size.width / widget.tempMedias.length,
                                decoration: BoxDecoration(
                                  color: index == indexMedia
                                      ? Colors.white
                                      : const Color.fromARGB(255, 138, 134, 134)
                                          .withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            )),
                  )),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$firstname $age",
                  style: const TextStyle(color: Colors.black, fontSize: 30),
                ),
                Row(
                  children: [
                    const Icon(Icons.school),
                    Text(editProfileViewModel.user!.job_title ?? "")
                  ],
                ),
                const Row(
                  children: [Icon(Icons.home), Text("Lives in Ha Noi")],
                ),
                const Row(
                  children: [
                    Icon(Icons.location_city),
                    Text("2 kilometer away")
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 1,
            color: const Color.fromARGB(255, 228, 226, 226),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Text(editProfileViewModel.user!.description ?? ""),
          ),
          Container(
            height: 1,
            color: const Color.fromARGB(255, 228, 226, 226),
          ),
        ],
      )),
    );
  }

  @override
  void initState() {
    EditProfileViewModel editProfileViewModel =
        Provider.of<EditProfileViewModel>(context, listen: false);

    for (int i = 0; i < 9; i++) {
      String order = i.toString();
      if (editProfileViewModel.photoPendingUpload.containsKey(order) &&
          editProfileViewModel.photoWithOrder.containsKey(order)) {
        continue;
      }

      if (editProfileViewModel.photoPendingUpload[order] != null) {
        widget.tempMedias.add(editProfileViewModel.photoPendingUpload[order]);
        continue;
      }

      if (editProfileViewModel.photoWithOrder[order] != null) {
        widget.tempMedias.add(editProfileViewModel.photoWithOrder[order]);
      }
    }

    super.initState();
  }
}
