import 'package:WEB_flutter/models/modelsViews/userInfo.dart';
import 'package:http/http.dart' as http;
import 'package:WEB_flutter/config/config.dart';
import 'dart:convert';

class APIUsers {
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static Future<List<UserInfo>> getAllUsersByPostID(String jwt, int id) async {
    var url = getUsersThatReactedOnPostURL + "/" + id.toString();
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

  static Future<UserInfo> fetchUserData(int id, String jwt) async {
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
    UserInfo user = UserInfo.fromObject(data2);
    return user;
  }

  static Future<List<UserInfo>> getAllUsers(String jwt) async {
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();
    var response = await http.get(citizensURL + "/userId=0",
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<UserInfo> allUserList = new List<UserInfo>();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var user in data) {
        allUserList.add(UserInfo.fromObject(user));
      }
      return allUserList;
    }
    return null;
  }

  static Future<List<UserInfo>> getReportedUsers(String jwt) async {
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();
    var response = await http.get(getReportedUsersURL,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<UserInfo> reportedUsers = new List<UserInfo>();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var user in data) {
        UserInfo u = UserInfo.fromObject(user);
        if (u.reportCount > 0) {
          reportedUsers.add(u);
        }
      }
      return reportedUsers;
    }
    return null;
  }

  static Future<List<UserInfo>> getBestUsers(
      String jwt, int userTypeId, int days, int number) async {
    var data = jsonDecode(jwt);
    jwt = data['token'].toString();
    var response = await http.get(
        getBestUsersURL +
            "/UserTypeID=" +
            userTypeId.toString() +
            "/days=" +
            days.toString() +
            "/userNumber=" +
            number.toString(),
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<UserInfo> bestList = new List<UserInfo>();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var user in data) {
        bestList.add(UserInfo.fromObject(user));
      }
      return bestList;
    }
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

  static Future<void> deleteUserOrInstitution(String jwt, int id) async {
    var url = userDataURL + "/" + id.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    await http.delete(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });
  }
}
