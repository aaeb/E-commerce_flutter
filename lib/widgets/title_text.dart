import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  Color textColor;
  double fontSize;

  TitleText(
      {super.key,
      required this.text,
      this.textColor = Colors.black,
      this.fontSize = 16});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
          color: textColor,
          overflow: TextOverflow.ellipsis),
    );
  }
}
