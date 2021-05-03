// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:mojgradapp/functions/local_notification_helper.dart';
// import 'package:mojgradapp/functions/secondPage.dart';

// class LocalNotification extends StatefulWidget {
//   @override
//   _LocalNotificationState createState() => _LocalNotificationState();
// }

// class _LocalNotificationState extends State<LocalNotification> {
//   final notifications = FlutterLocalNotificationsPlugin();

//   @override
//   void initState() {
//     super.initState();

//     final settingsAndroid = AndroidInitializationSettings('logoapp');

//     final settingsIOS = IOSInitializationSettings(
//         onDidReceiveLocalNotification: (id, title, body, payload) =>
//             onSelectNotification(payload));

//     notifications.initialize(
//         InitializationSettings(settingsAndroid, settingsIOS),
//         onSelectNotification: onSelectNotification);
//   }

//   Future onSelectNotification(String payload) async => await Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => SecondPage(payload: payload)),
//       );

//   @override
//   Widget build(BuildContext context) {
//     showOngoingNotification(notifications,
//                  title: 'Title', body: 'Body');
//     // return Padding(
//     //   padding: const EdgeInsets.all(8.0),
//     //   child: ListView(
//     //     children: <Widget>[
//     //       RaisedButton(
//     //           child: Text('Show notification'),
//     //           onPressed: () => showOngoingNotification(notifications,
//     //               title: 'Title', body: 'Body')),
//     //     ],
//     //   ),
//     // );
//     return Container();
//   }
// }

