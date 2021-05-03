import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mojgradapp/config/config.dart';
import 'package:mojgradapp/models/follow.dart';
import 'package:mojgradapp/models/modelsViews/userInfo.dart';

import '../main.dart';

class APIFollow {
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<List<UserInfo>> getFollowSugestions(String jwt) async {
    String url = getFollowSugestionsURL + loginUserID.toString();
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();
    var response = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });
    List<UserInfo> allUser = new List<UserInfo>();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var user in data) {
        allUser.add(UserInfo.fromObject(user));
      }
      return allUser;
    } else
      return null;
  }

  static Future<bool> checkIfFollow(String jwt, int userID) async {
    var url = checkIfFollowURL +
        "/" +
        loginUserID.toString() +
        "/" +
        userID.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var res = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    if (res.body == 'true')
      return true;
    else
      return false;
  }

  static Future<bool> addFollow(String jwt, int userID) async {
    var url = followURL;

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    Follow follow = new Follow(loginUserID, userID, DateTime.now(), false);
    var data2 = follow.toMap();
    var jsonBody = jsonEncode(data2);

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

  static Future<List<UserInfo>> getAllFollowingUsers(String jwt) async {
    var url = getAllFollowingUsersURL + "/" + loginUserID.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var response = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<UserInfo> userList = new List<UserInfo>();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var user in data) {
        userList.add(UserInfo.fromObject(user));
      }
      return userList;
    } else
      return null;
  }

  static Future<List<UserInfo>> getAllFollowersOfUser(String jwt) async {
    var url = getAllFollowersOfUserURL + "/" + loginUserID.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var response = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<UserInfo> userList = new List<UserInfo>();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var user in data) {
        userList.add(UserInfo.fromObject(user));
      }
      return userList;
    } else
      return null;
  }
}
