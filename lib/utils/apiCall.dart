// ignore_for_file: file_names
import 'dart:convert';
import 'package:dermacare_ai/const/apiconst.dart';
import 'package:dermacare_ai/controller/getStorage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

// final LocalStorage storage = LocalStorage('devfinder_vault.json');
bool isLoggedIn = false;

// Future checkIfValidToken(accessToken) async {
//   var response = await Api.get(ApiConst.verifyAuthentication);
//   if (response.statusCode == 200) {
//     return true;
//   } else {
//     return false;
//   }
// }

// Future<dynamic> getTokenFromStorage() async
// // A function that checks if the token is valid and returns the token if it is valid.
// // If the token is not valid, it refreshes the token and returns the new token.
// // Else, it returns null.
// {
//   var accessToken = await ;
//   // print(accessToken);
//   if (accessToken != null) {
//     if (await checkIfValidToken(accessToken) == true) {
//       return accessToken;
//     } else {
//       var response = await Api.post(ApiConst.refreshAccessToken, {
//         "refresh": storage.getItem('refresh_token'),
//       });
//       storage.setItem('access_token', null);
//       storage.setItem('refresh_token', null);
//       storage.setItem('access_token', response['access']);
//       storage.setItem('refresh_token', response['refresh']);
//       return response['access'];
//     }
//   } else {
//     return null;
//   }
// }

class Api {
  final storage = Get.put(StoreController());
  Future get(String endPoint) async {
    var accessToken = storage.readAccess();
    if (accessToken != null) {
      if (JwtDecoder.isExpired(accessToken)) {
        var response = await http.post(
          Uri.parse(ApiConst.BASEURL + ApiConst.refreshAccessToken),
          body: {"refresh": storage.readRefresh()},
        );
        var data = jsonDecode(response.body);
        storage.box.erase();
        storage.writeAccess(data['access']);
        storage.writeRefresh(data['refresh']);
        var response2 = await http.get(Uri.parse(ApiConst.BASEURL + endPoint),
            headers: {"Authorization": "Bearer ${data['access']}"});
        var data2 = jsonDecode(response2.body);
        return data2;
      } else {
        var response = await http.get(Uri.parse(ApiConst.BASEURL + endPoint),
            headers: {"Authorization": "Bearer $accessToken"});
        var data = jsonDecode(response.body);
        return data;
      }
    } else {
      var response = await http.get(Uri.parse(ApiConst.BASEURL + endPoint),
          headers: {"Authorization": "Bearer $accessToken"});
      var data = jsonDecode(response.body);
      return data;
    }
  }

  Future post(String endPoint, dynamic data) async {
    var accessToken = storage.readAccess();
    if (accessToken != null) {
      if (JwtDecoder.isExpired(accessToken)) {
        var response = await http.post(
          Uri.parse(ApiConst.BASEURL + ApiConst.refreshAccessToken),
          body: {"refresh": storage.readRefresh()},
        );
        var data = jsonDecode(response.body);
        storage.box.erase();
        storage.writeAccess(data['access']);
        storage.writeRefresh(data['refresh']);
        var response2 = await http.post(Uri.parse(ApiConst.BASEURL + endPoint),
            body: data, headers: {"Authorization": "Bearer $accessToken"});

        return jsonDecode(response2.body);
      } else {
        var response = await http.post(Uri.parse(ApiConst.BASEURL + endPoint),
            body: data, headers: {"Authorization": "Bearer $accessToken"});

        // print(response.body);
        return jsonDecode(response.body);
      }
    } else {
      var response = await http.post(Uri.parse(ApiConst.BASEURL + endPoint),
          body: data, headers: {"Authorization": "Bearer $accessToken"});

      // print(response.body);
      return jsonDecode(response.body);
    }
  }

  Future put(String endPoint, dynamic data) async {
    var accessToken = storage.readAccess();
    if (accessToken != null) {
      if (JwtDecoder.isExpired(accessToken)) {
        var response = await http.post(
          Uri.parse(ApiConst.BASEURL + ApiConst.refreshAccessToken),
          body: {"refresh": storage.readRefresh()},
        );
        var data = jsonDecode(response.body);
        storage.box.erase();
        storage.writeAccess(data['access']);
        storage.writeRefresh(data['refresh']);
        var response2 = await http.put(Uri.parse(ApiConst.BASEURL + endPoint),
            body: data, headers: {"Authorization": "Bearer $accessToken"});

        return jsonDecode(response2.body);
      } else {
        var response = await http.put(Uri.parse(ApiConst.BASEURL + endPoint),
            body: data, headers: {"Authorization": "Bearer $accessToken"});

        // print("Response: ${response.body}");
        return response;
      }
    } else {
      var response = await http.put(Uri.parse(ApiConst.BASEURL + endPoint),
          body: data, headers: {"Authorization": "Bearer $accessToken"});
      // print("Response: ${response.body}");
      return jsonDecode(response.body);
    }
  }
}
