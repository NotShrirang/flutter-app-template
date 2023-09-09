// ignore_for_file: file_names
import 'dart:convert';

import 'package:dermacare_ai/const/apiConst.dart';
import 'package:dermacare_ai/const/colorConst.dart';
import 'package:dermacare_ai/controller/signin.dart';
import 'package:dermacare_ai/widget/containerWidgets.dart';
import 'package:dermacare_ai/widget/textWidgets.dart';
import 'package:dermacare_ai/widget/textfieldWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BackgroundColorDC(
      body: ListView(
        children: [
          SizedBox(
            height: Get.height * 0.05,
          ),
          TitleText(
            text: 'Sign Up',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: ColorsConst.white,
          ),
          SizedBox(
            height: Get.height * 0.03,
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB(Get.width * 0.07, 0, Get.width * 0.07, 0),
            child: MyTextField(
              controller: nameController,
              placeholder: 'Name',
              color: ColorsConst.white,
              obsceureText: false,
            ),
          ),
          SizedBox(
            height: Get.width * 0.05,
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB(Get.width * 0.07, 0, Get.width * 0.07, 0),
            child: MyTextField(
              controller: usernameController,
              placeholder: 'Enter your username',
              color: ColorsConst.white,
              obsceureText: false,
            ),
          ),
          SizedBox(
            height: Get.width * 0.05,
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB(Get.width * 0.07, 0, Get.width * 0.07, 0),
            child: MyTextField(
              controller: passwordController,
              placeholder: 'Enter your password',
              color: ColorsConst.white,
              obsceureText: true,
            ),
          ),
          SizedBox(
            height: Get.width * 0.05,
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB(Get.width * 0.07, 0, Get.width * 0.07, 0),
            child: MyTextField(
              controller: rePasswordController,
              placeholder: 'Re-enter your password',
              color: ColorsConst.white,
              obsceureText: true,
            ),
          ),
          SizedBox(
            height: Get.width * 0.05,
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB(Get.width * 0.07, 0, Get.width * 0.07, 0),
            child: MyTextField(
              controller: emailController,
              placeholder: 'Enter your email',
              color: ColorsConst.white,
              obsceureText: false,
            ),
          ),
          SizedBox(
            height: Get.width * 0.1,
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB(Get.width * 0.07, 0, Get.width * 0.07, 0),
            child: Container(
              width: Get.width * 0.6,
              height: Get.height * 0.05,
              decoration: BoxDecoration(
                border:
                    Border.all(color: HexColor(ColorsConst.white), width: 0.4),
                borderRadius: BorderRadius.circular(30),
                color: HexColor(ColorsConst.orange),
              ),
              child: TextButton(
                  onPressed: handleSignUp,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    elevation: MaterialStateProperty.all<double>(50),
                    overlayColor: MaterialStateProperty.all<Color>(
                        HexColor(ColorsConst.orange)),
                  ),
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                        color: HexColor(ColorsConst.white),
                        fontSize: 15,
                        fontFamily: GoogleFonts.mulish().fontFamily,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Future handleSignUp() async {
    if (nameController.text.trim().isEmpty ||
        usernameController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        rePasswordController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please fill all the fields",
          snackPosition: SnackPosition.TOP,
          barBlur: 20,
          colorText: HexColor(ColorsConst.white));
      return;
    }
    if (passwordController.text.trim() != rePasswordController.text.trim()) {
      Get.snackbar("Error", "Passwords does not match",
          snackPosition: SnackPosition.TOP,
          barBlur: 20,
          colorText: HexColor(ColorsConst.white));
      return;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar("Error", "Please enter a valid email.",
          snackPosition: SnackPosition.TOP,
          barBlur: 20,
          colorText: HexColor(ColorsConst.white));
      return;
    }

    var response = await http.post(
        Uri.parse("${ApiConst.BASEURL}${ApiConst.getAllProfiles}create/"),
        body: {
          "first_name": nameController.text.trim(),
          "username": usernameController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        });

    final data = const JsonDecoder().convert(response.body);

    if (response.statusCode == 200) {
      Get.snackbar("Success",
          "Welcome to dermacare_ai, ${usernameController.text.trim()}!",
          snackPosition: SnackPosition.TOP,
          colorText: HexColor(ColorsConst.white));

      final storage = Get.put(MyController());
      storage.handleLogin(
          usernameController.text.trim(), passwordController.text.trim());
    } else if (response.statusCode == 400) {
      Get.snackbar("Error", data['username'][0],
          snackPosition: SnackPosition.TOP,
          colorText: HexColor(ColorsConst.white));
      usernameController.clear();
      passwordController.clear();
      rePasswordController.clear();
      emailController.clear();
      nameController.clear();
      return;
    } else {
      Get.snackbar("Error", "Something went wrong",
          snackPosition: SnackPosition.TOP,
          colorText: HexColor(ColorsConst.white));
      usernameController.clear();
      passwordController.clear();
      rePasswordController.clear();
      emailController.clear();
      nameController.clear();
      return;
    }
  }
}
