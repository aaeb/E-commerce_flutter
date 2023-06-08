import 'package:ecommerce/widgets/subtitle_text.dart';
import 'package:flutter/material.dart';

class TextAndIcon extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color iconColor;

  const TextAndIcon(
      {super.key,
      required this.iconData,
      required this.text,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData,color: iconColor,),
       const SizedBox(
          width: 5,
        ),
        SubTitleText(text: text,fontColor: Colors.grey,),
      ],
    );
  }
}
