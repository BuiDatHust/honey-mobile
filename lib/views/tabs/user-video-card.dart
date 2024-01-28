import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class UserVideoCard extends StatefulWidget {
  final String videoUrl;

  const UserVideoCard({super.key, required this.videoUrl});

  @override
  State<UserVideoCard> createState() => _UserVideoCardState();
}

class _UserVideoCardState extends State<UserVideoCard> {
  late VideoPlayerController videoPlayerController;

  @override
  Widget build(BuildContext context) {
    return VideoPlayer(videoPlayerController);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
          ..initialize();
    setState(() {
      videoPlayerController.setLooping(true);
      videoPlayerController.play();
    });

    super.initState();
  }
}
