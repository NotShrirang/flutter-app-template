// ignore_for_file: file_names, must_be_immutable, prefer_typing_uninitialized_variables
import 'package:my_project/const/colorConst.dart';
import 'package:my_project/const/apiConst.dart';
import 'package:my_project/const/iconConst.dart';
import 'package:my_project/controller/getStorage.dart';
import 'package:my_project/controller/signin.dart';
import 'package:my_project/utils/apiCall.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_project/const/colorConst.dart';

class BackgroundColorDC extends StatelessWidget {
  Widget body, bottomNavigationBar;
  PreferredSizeWidget appBar;
  BackgroundColorDC(
      {super.key,
      this.appBar = const PreferredSize(
          preferredSize: Size.fromHeight(0.0), child: SizedBox()),
      required this.body,
      this.bottomNavigationBar = const SizedBox()});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
              HexColor(ColorsConst.gradientRed),
              HexColor(ColorsConst.gradientBlack),
              HexColor(ColorsConst.gradientBlue)
            ])),
        child: body,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
