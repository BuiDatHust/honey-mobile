import 'package:flutter/material.dart';

class CircularLoadingWidget extends StatelessWidget {
  double? width;
  double? height;

  CircularLoadingWidget({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    width ??= MediaQuery.of(context).size.width;
    height ??= MediaQuery.of(context).size.height * 0.8;

    return SizedBox(
      width: width,
      height: height,
      child: const CircularProgressIndicator(
          color: Color.fromARGB(255, 180, 118, 25)),
    );
  }
}
