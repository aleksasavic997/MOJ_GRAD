import 'dart:convert' as convert;
import 'package:WEB_flutter/config/config.dart';
import 'package:http/http.dart' as http;

class Admin {
  int id;
  String username;
  String password;

  Admin(username, password) {
    this.username = username;
    this.password = password;
  }

  Admin.id(id, username, password) {
    this.id = id;
    this.username = username;
    this.password = password;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map['id'] = id;
    map['username'] = username;
    map['password'] = password;
    return map;
  }

  Admin.fromObject(dynamic o) {
    this.id = o['id'];
    this.username = o['username'];
    this.password = o['password'];
  }

  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static Future<String> checkAdmin(String username, String password) async {
    String url = checkAdminURL;

    var data = Map();
    data['username'] = username;
    data['password'] = password;

    var jsonBody = convert.jsonEncode(data);
    print(jsonBody);
    var res = await http.post(url, headers: header, body: jsonBody);
    print(res.statusCode);
    String data2 = res.body.toString();
    if (res.statusCode != 200) return ('false');
    return data2;
  }
}
