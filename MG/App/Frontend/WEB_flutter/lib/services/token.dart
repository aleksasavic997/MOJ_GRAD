import 'dart:convert';
import 'dart:html';

import 'package:WEB_flutter/services/APIInstitutions.dart';

import '../main.dart';
import 'APIAdmin.dart';

class Token {

  static set setToken(String value) => window.sessionStorage["jwt"] = value;
  static String get jwt => window.sessionStorage["jwt"];
  static set deleteToken(String value) => window.sessionStorage["jwt"] = null;


  /*static final storage = new FlutterSecureStorage();
  static String jwt;

  static void setSecureStorage(String key, String data) async {
    await storage.write(key: key, value: data);
    jwt = await storage.read(key: "jwt");
  }

  static Future<String> getSecureStorage(String key) async {
    return await storage.read(key: key);
  }*/

  static Future<String> get jwtOrEmpty async {
    // var jwt = await storage.read(key: "jwt");
    var newjwt = jwt;
    if (newjwt == null) return "";
    var token = json.decode(
        ascii.decode(base64.decode(base64.normalize(newjwt.split('.')[1]))));
        print(token['given_name']);
    if(token['given_name'] == 'admin')
    {
      loginAdmin = token['sub'];
      var id = int.parse(token['nameid']);
      admin = await APIAdmin.getAdminByID(newjwt, id);
      loginInstitution = null;
    }
    else
   {
      loginInstitution = await APIInstitutions.getInstitutionByID(int.parse(token['sub']), newjwt);
      loginInstitutionID = loginInstitution.id;
      loginAdmin = '';
      admin = null;
   }
    // loginUser = await APIServices.getUserInfoById(loginUserID, jwt);
    //print(loginUser.name);
    print(newjwt);
    return newjwt;
  }
}
