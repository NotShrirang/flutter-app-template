// ignore_for_file: file_names

import 'package:my_project/const/colorConst.dart';
import 'package:my_project/widget/containerWidgets.dart';
import 'package:my_project/widget/textWidgets.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundColorDC(
      body: Center(
          child: TitleText(text: 'My Project', color: ColorsConst.white)),
    );
  }
}
