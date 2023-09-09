import 'dart:convert';

import 'package:dermacare_ai/const/apiconst.dart';
import 'package:dermacare_ai/const/colorconst.dart';
import 'package:dermacare_ai/controller/getStorage.dart';
import 'package:dermacare_ai/screen/HomePage/homePage.dart';
import 'package:dermacare_ai/screen/HomePage/welcomePage.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../utils/apiCall.dart';

class MyController extends GetxController {
  final storage = StoreController();

  Future checkIfValidToken(accessToken) async {
    var response = await Api().get(ApiConst.verifyAuthentication);
    var responseBody = json.decode(response.body);
    try {
      if (responseBody['code'] == 'token_not_valid') {
        return false;
      }
    } catch (e) {
      print(e);
    }
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> getTokenFromStorage() async
// A function that checks if the token is valid and returns the token if it is valid.
// If the token is not valid, it refreshes the token and returns the new token.
// Else, it returns null.
  {
    var accessToken = await storage.readAccess();
    if (accessToken != null) {
      if (await checkIfValidToken(accessToken) == true) {
        return accessToken;
      } else {
        var response = await Api().post(ApiConst.refreshAccessToken, {
          "refresh": storage.readRefresh(),
        });
        storage.box.erase();
        return response['access'];
      }
    } else {
      return null;
    }
  }

  Future handleLogin(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please fill all the fields",
          snackPosition: SnackPosition.TOP,
          barBlur: 20,
          colorText: HexColor(ColorsConst.white));
      return;
    }
    var response = await Api().post(ApiConst.getAccessToken, {
      "username": username,
      "password": password,
    });
    if (response != null) {
      storage.box.erase();
      storage.writeAccess(response['access']);
      storage.writeRefresh(response['refresh']);
      var currentUser = await Api().get(ApiConst.getCurrentUser);
      storage.writeUid(currentUser['uuid']);
      Get.offAll(() => const HomePage(title: 'DevFinder'),
          transition: Transition.rightToLeft);
      storage.isUserlogin(true);
    } else {
      Get.to(() => const WelcomePage());
    }
  }

  dynamic signOut() async {
    await storage.box.erase();
    return true;
  }
}
