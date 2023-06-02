import 'package:flutter/material.dart';

class VerticalText extends StatelessWidget {
  const VerticalText(this.name, {super.key, required this.isSelect});

  final String name;
  final bool isSelect;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
        quarterTurns: 3,
        child: FittedBox(
          child: Text(
            name,
            style: TextStyle(
                fontSize: 16,
                fontFamily: "GenSenRounded",
                color: isSelect ? Colors.black : Colors.grey,
                fontWeight: isSelect ? FontWeight.bold : null),
          ),
        ));
  }
}