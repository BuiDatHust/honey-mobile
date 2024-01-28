// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// class AudioMessage extends StatefulWidget {
//   const AudioMessage({super.key});

//   @override
//   State<AudioMessage> createState() => _AudioMessageState();
// }

// class _AudioMessageState extends State<AudioMessage> {
//   AudioPlayer? _player;

//   @override
//   Widget build(BuildContext context) {
//     return Slider(
//         value: _player.,
//         min: 0.0,
//         max: _duration.inSeconds.toDouble(),
//         onChanged: (double value) {
//           setState(() {
//             seekToSecond(value.toInt());
//             value = value;
//           });
//         });
//   }

//   @override
//   void dispose() {
//     _player?.dispose();
//     super.dispose();
//   }

//   void _play() {
//     _player?.dispose();
//     final player = _player = AudioPlayer();
//     player.play(AssetSource('click.mp3'));
//   }
// }
