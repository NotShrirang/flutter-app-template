// ignore_for_file: file_names

import 'package:my_project/const/colorConst.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  TextEditingController controller;
  String placeholder;
  String color;
  bool obsceureText;

  MyTextField(
      {super.key,
      required this.controller,
      required this.placeholder,
      required this.color,
      required this.obsceureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obsceureText,
      style: TextStyle(color: HexColor(ColorsConst.white)),
      decoration: InputDecoration(
        hintText: placeholder,
        fillColor: HexColor(ColorsConst.darkGrey),
        filled: true,
        hintStyle: TextStyle(color: HexColor(ColorsConst.white)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TextFieldDF extends StatelessWidget {
  dynamic onChanged;
  TextEditingController controller;
  String placeholder;
  String color;
  bool obsceureText;
  int maxLines;

  TextFieldDF(
      {super.key,
      required this.onChanged,
      required this.controller,
      required this.placeholder,
      required this.color,
      this.obsceureText = false,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: TextStyle(color: HexColor(ColorsConst.white)),
      controller: controller,
      obscureText: obsceureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: placeholder,
        label: Text(
          placeholder,
          style: TextStyle(color: HexColor(ColorsConst.orange)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor(ColorsConst.orange)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor(ColorsConst.orange)),
        ),
        fillColor: HexColor(ColorsConst.darkGrey),
        filled: true,
        hintStyle: TextStyle(color: HexColor(ColorsConst.white)),
      ),
    );
  }
}
