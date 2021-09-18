import 'package:flutter/material.dart';

class StateWidget extends StatelessWidget {
  const StateWidget({
    required this.icon,
    required this.text,
    required this.bgColor,
    Key? key,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final Color bgColor;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          color: bgColor.withOpacity(.5),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(
                icon,
                size: 45,
                color: Colors.white,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                text,
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
            ],
          ),
        )
      ],
    );
  }
}
