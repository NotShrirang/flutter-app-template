// ignore_for_file: file_names

import 'package:my_project/const/colorConst.dart';
import 'package:my_project/widget/containerWidgets.dart';
import 'package:my_project/widget/textWidgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return BackgroundColorDC(
      body: Center(child: TitleText(text: title, color: ColorsConst.white)),
    );
  }
}
