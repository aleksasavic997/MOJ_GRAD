import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mojgradapp/config/config.dart';
import 'package:mojgradapp/models/modelsViews/notificationInfo.dart';

import '../main.dart';

class APINotification {
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<List<NotificationInfo>> getAllReadNotifications(
      String jwt) async {
    var url = getAllReadNotificationsURL + loginUserID.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var res = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<NotificationInfo> notifications = new List<NotificationInfo>();

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      for (var notification in data) {
        notifications.add(NotificationInfo.fromObject(notification));
      }
      return notifications;
    } else
      return null;
  }

  static Future<List<NotificationInfo>> getAllNotReadNotifications(
      String jwt) async {
    var url = getAllNotReadNotificationsURL + loginUserID.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var res = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });

    List<NotificationInfo> notifications = new List<NotificationInfo>();

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      for (var notification in data) {
        notifications.add(NotificationInfo.fromObject(notification));
      }
      return notifications;
    } else
      return null;
  }

  static Future<bool> changeNotificationToRead(
      String jwt, NotificationInfo notification) async {
    var url = changeNotificationToReadURL;

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var data2 = notification.toMap();
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

  static Future<void> readAllNotifications(String jwt) async {
    var url = readAllNotificationsURL + loginUserID.toString();

    var data = jsonDecode(jwt);
    jwt = data['token'].toString();

    var res = await http.get(url,
        headers: header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwt'
        });
    print(res.statusCode);
  }
}
