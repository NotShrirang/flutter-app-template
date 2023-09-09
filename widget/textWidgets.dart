// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: must_be_immutable
class TitleText extends StatelessWidget {
  String text;
  String color;
  double fontSize;
  var fontFamily;
  var fontWeight;
  var textAlign;

  TitleText({
    super.key,
    required this.text,
    required this.color,
    this.fontSize = 32,
    this.fontFamily = "Roboto",
    this.fontWeight = FontWeight.bold,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          color: HexColor(color),
          fontSize: fontSize,
          fontFamily: fontFamily,
          fontWeight: fontWeight),
    );
  }
}
