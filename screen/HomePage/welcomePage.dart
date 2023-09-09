// ignore_for_file: file_names

import 'package:dermacare_ai/const/colorConst.dart';
import 'package:dermacare_ai/widget/containerWidgets.dart';
import 'package:dermacare_ai/widget/textWidgets.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundColorDC(
      body: Center(
          child: TitleText(text: 'DermaCare AI', color: ColorsConst.white)),
    );
  }
}
