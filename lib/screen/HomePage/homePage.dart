// ignore_for_file: file_names

import 'package:dermacare_ai/const/colorConst.dart';
import 'package:dermacare_ai/widget/containerWidgets.dart';
import 'package:dermacare_ai/widget/textWidgets.dart';
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
