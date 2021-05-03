import 'package:WEB_flutter/models/admin.dart';
import 'package:http/http.dart' as http;
import 'package:WEB_flutter/config/config.dart';
import 'dart:convert';

class APIAdmin {
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static Future<Admin> getAdminByID(String jwt, int id) async {
    String url = adminURL + "/" + id.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var res = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });
    var data2 = jsonDecode(res.body);
    Admin admin = Admin.fromObject(data2);

    return admin;
  }

  static Future<bool> changeAdmin(String jwt, Admin admin) async {
    String url = changeAdminURL;

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var data2 = admin.toMap();
    var jsonBody = jsonEncode(data2);

    print(admin.username);
    print(admin.password);

    var res = await http.post(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        },
        body: jsonBody);

    if (res.body == 'true')
      return true;
    else
      return false;
  }

  static Future<bool> addAdmin(String jwt, Admin admin) async {
    String url = adminURL + "/addAdmin";

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var data2 = admin.toMap();
    var jsonBody = jsonEncode(data2);

    print(data2);

    var res = await http.post(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        },
        body: jsonBody);

    print(res.statusCode);
    print(res.body);

    if (res.body == 'true')
      return true;
    else
      return false;
  }
}
