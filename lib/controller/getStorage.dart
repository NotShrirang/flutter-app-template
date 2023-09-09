import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StoreController extends GetxController {
  // declaring var for box
  final box = GetStorage();

// Storage Name

  final String accessToken = "accessToken";
  final String refreshToken = "refreshToken";
  final String uid = "uid";
  final String isLoginN = "isLogin";

// check if user has login or not
  bool get isLogin => box.read(isLoginN) ?? false;

// change if the user has login or not
  void isUserlogin(bool val) => box.write(isLoginN, val);

// read access
  readAccess() {
    return box.read(accessToken);
  }

// write access
  writeAccess(String lang) {
    return box.write(accessToken, lang);
  }

// read refresh
  readRefresh() {
    return box.read(refreshToken);
  }

// write refresh
  writeRefresh(String lang) {
    return box.write(refreshToken, lang);
  }

// read Uid
  readUid() {
    return box.read(uid);
  }

// write Uid
  writeUid(String lang) {
    return box.write(uid, lang);
  }
}
