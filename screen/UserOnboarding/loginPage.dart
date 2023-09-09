import 'package:my_project/controller/signin.dart';
import 'package:my_project/widget/containerWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_project/const/colorConst.dart';
import 'package:my_project/const/iconConst.dart';
import 'package:my_project/widget/textWidgets.dart';
import 'package:my_project/widget/textfieldWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    GoogleSignIn googleSignIn = GoogleSignIn(
        clientId:
            '706084958611-1tgh59e7l7cakff8v76lbldqppqohni6.apps.googleusercontent.com',
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
          'profile'
        ]);

    Future<void> handleGoogleSignIn() async {
      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        final googleuser = await googleSignIn.signIn();
        if (googleuser == null) return;
        final googleAuth = await googleuser.authentication;

        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        await auth.signInWithCredential(credential);
      } catch (error) {
        print(error);
      }
    }

    final storage = Get.put(MyController());
    return BackgroundColorDC(
      body: Center(
          child: ListView(
        children: [
          SizedBox(
            height: Get.height * 0.05,
          ),
          TitleText(
            text: 'Log In',
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
            child: TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                      color: HexColor(ColorsConst.orange),
                      decoration: TextDecoration.underline,
                      fontSize: 15),
                )),
          ),
          SizedBox(
            height: Get.width * 0.05,
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
                  onPressed: () => storage.handleLogin(
                      usernameController.text.trim(),
                      passwordController.text.trim()),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    elevation: MaterialStateProperty.all<double>(50),
                    overlayColor: MaterialStateProperty.all<Color>(
                        HexColor(ColorsConst.orange)),
                  ),
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(
                        color: HexColor(ColorsConst.white),
                        fontSize: 15,
                        fontFamily: GoogleFonts.mulish().fontFamily,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ),
          SizedBox(
            height: Get.width * 0.05,
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding:
                  EdgeInsets.fromLTRB(Get.width * 0.07, 0, Get.width * 0.07, 0),
              child: Text("-- OR --",
                  style: TextStyle(
                      color: HexColor(ColorsConst.white),
                      fontSize: 15,
                      fontFamily: GoogleFonts.mulish().fontFamily,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(
            height: Get.width * 0.05,
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB(Get.width * 0.07, 0, Get.width * 0.07, 0),
            child: Container(
              width: Get.width * 0.7,
              height: Get.height * 0.08,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border:
                    Border.all(color: HexColor(ColorsConst.white), width: 0.4),
                borderRadius: BorderRadius.circular(10),
                color: HexColor(ColorsConst.darkGrey),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: Get.width * 0.05,
                  ),
                  SvgPicture.asset(
                    IconConst.googleIcon,
                    width: Get.width * 0.1,
                    height: Get.width * 0.1,
                  ),
                  SizedBox(
                    width: Get.width * 0.05,
                  ),
                  TextButton(
                    onPressed: handleGoogleSignIn,
                    child: Text(
                      'Sign in with Google',
                      style: TextStyle(
                          color: HexColor(ColorsConst.white),
                          fontSize: 15,
                          fontFamily: GoogleFonts.mulish().fontFamily,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.05,
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
