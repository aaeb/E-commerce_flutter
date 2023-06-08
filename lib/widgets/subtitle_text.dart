import 'package:flutter/material.dart';


class SubTitleText extends StatelessWidget {
  final String text;
  Color fontColor;
  double fontSize;

  SubTitleText(
      {super.key,
      required this.text,
      this.fontColor = Colors.black,
      this.fontSize = 11});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
            color: fontColor));
  }
}
