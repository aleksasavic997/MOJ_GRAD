import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mojgradapp/services/APIUsers.dart';
import '../main.dart';

class Token {
  static final storage = new FlutterSecureStorage();
  static String jwt;

  static void setSecureStorage(String key, String data) async {
    await storage.write(key: key, value: data);
    jwt = await storage.read(key: "jwt");
    print('SET SECURE STORAGE');
    print(jwt);
  }

  static Future<String> getSecureStorage(String key) async {
    return await storage.read(key: key);
  }

  static Future<String> get jwtOrEmpty async {
    // var jwt = await storage.read(key: "jwt");
    jwt = await getSecureStorage('jwt');
    if (jwt == null) return "";
    var token = json.decode(
        ascii.decode(base64.decode(base64.normalize(jwt.split('.')[1]))));

    if (DateTime.fromMillisecondsSinceEpoch(token["exp"] * 1000)
        .isAfter(DateTime.now())) {
      loginUserID = int.parse(token['sub']);
      loginUser = await APIUsers.getUserInfoById(loginUserID, jwt);
      return jwt;
    }

    return "";
  }
}
