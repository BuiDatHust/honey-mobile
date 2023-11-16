import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;
  final String text;
  final void function;

  const CustomButton({
    Key? key,
    required this.tabController,
    required this.text,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).primaryColor,
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          if (tabController.index != 5) {
            tabController.animateTo(tabController.index + 1);
          }

          if (tabController.index == 2) {}
          if (tabController.index == 3) {}
          if (tabController.index == 5) {}
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
