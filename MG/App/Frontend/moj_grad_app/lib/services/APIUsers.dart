import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mojgradapp/config/config.dart';
import 'package:mojgradapp/models/modelsViews/userInfo.dart';
import 'package:mojgradapp/models/userData.dart';
import 'package:mojgradapp/models/userReport.dart';

import '../main.dart';

class APIUsers {
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  static Future fetchUserData(String jwt) async {
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();
    return await http.get(userDataURL,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });
  }

  static Future<List<UserInfo>> getAllUsers(String jwt) async {
    String url = citizensURL + "/userId=" + loginUserID.toString();
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

  static Future<UserInfo> getUserInfoById(int id, String jwt) async {
    String url = userDataURL + "/" + id.toString();
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();
    var res = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });
    var data2 = jsonDecode(res.body);
    UserInfo userInfo = UserInfo.fromObject(data2);

    return userInfo;
  }

  static Future<bool> changeUserInformation(
      String jwt,
      String name,
      String lastname,
      String username,
      String email,
      String pass,
      String profilePhoto,
      int cityID,
      String number) async {
    String url = changeUserInfoURL;
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    UserData user = new UserData.id(loginUserID, name, lastname, username, pass,
        email, number, cityID, profilePhoto, 1, true);

    var data2 = user.toMap();
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

  static Future<List<UserInfo>> getUsersThatLikedComment(
      String jwt, int commentID) async {
    var url = getUsersThatLikedCommentURL + '/' + commentID.toString();

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

  static Future<bool> addUserReport(String jwt, UserReport report) async {
    var url = userReportURL;

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var data2 = report.toMap();
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

  static Future<bool> isUserLogged(String jwt, int id) async {
    var url = loginURL + "/IsLogged/" + id.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var res = await http.post(url,
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

  static Future<List<UserInfo>> getUsersThatDislikedComment(
      String jwt, int commentID) async {
    var url = getUsersThatDislikedCommentURL + '/' + commentID.toString();

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

  static Future<List<UserInfo>> getAllUsersByPostID(String jwt, int id) async {
    var url = getUsersThatReactedOnPost + "/" + id.toString();
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var response = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<UserInfo> users = new List<UserInfo>();

    if (response.statusCode == 200) {
      var data2 = jsonDecode(response.body);

      for (var user in data2) {
        users.add(UserInfo.fromObject(user));
      }
      return users;
    }
    return null;
  }

  static Future<bool> deleteUserById(int id, String jwt) async {
    var urlUserById = userDataURL + "/" + id.toString();
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var res = await http.delete(urlUserById,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    return Future.value(res.statusCode == 201 ? true : false);
  }

  static Future<bool> forgottenPassword(String username) async {
    var urlUserById = forgottenPasswordURL + "/username=" + username;

    var res = await http.post(urlUserById,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });

print(res.body);
    if (res.body == "true")
      return true;
    else
      return false;
  }
}
