import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mojgradapp/functions/loading.dart';
import 'package:mojgradapp/functions/localNotification.dart';
import 'package:mojgradapp/models/modelsViews/notificationInfo.dart';
import 'package:mojgradapp/screens/posts/viewPostPage.dart';
import 'package:mojgradapp/screens/profilePage.dart';
import 'package:mojgradapp/services/APINotifications.dart';
import 'package:mojgradapp/services/APIUsers.dart';
import 'package:mojgradapp/services/token.dart';

import '../main.dart';

//neprocitana obavestenja

class BuildBodyUnread extends StatefulWidget {
  static List<NotificationInfo> notificationList = List<NotificationInfo>();
  BuildBodyUnread({Key key}) : super(key: key);
  @override
  BuildBodyUnreadState createState() => BuildBodyUnreadState();
}

class BuildBodyUnreadState extends State<BuildBodyUnread> {
  static const int postReactionChallenge = 1;
  static const int postReactionSolution = 2;
  static const int solutionForChallenge = 3;
  static const int commentLike = 4;
  static const int commentDislike = 5;
  static const int commentForPost = 6;
  static const int followType = 7;
  static const int rank = 8;

  Widget noteficationList(List<NotificationInfo> notificationListUnread) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: FloatingActionButton.extended(
            onPressed: () {
              showAlertDialog(context);
            },
            label: Text(
              'Obeleži sve kao pročitano',
              style: TextStyle(fontSize: 15.0),
            ),
            icon: Icon(
              Icons.chrome_reader_mode,
              size: 15.0,
            ),
            backgroundColor: Colors.amber[900],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        SizedBox(
            child: ListView.separated(
              controller: new ScrollController(),
                shrinkWrap: true,
                itemCount: notificationListUnread.length,
                itemBuilder: (context, index) {
                  return _cardNotes(notificationListUnread[index]);
                },
                separatorBuilder: (context, index) {
                  return Divider();
                })),
      ],
    );
  }

  Widget _cardNotes(note) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Card(
          child: ListTile(
              onTap: () async {
                setState(() {
                  APINotification.changeNotificationToRead(Token.jwt, note);
                  //       .then((value) => sendNotification(loginUserID));
                });

                if (note.type == followType || note.type == rank) {
                  ProfilePage.user =
                      await APIUsers.getUserInfoById(note.userId, Token.jwt);
                  Navigator.of(context).pushNamed('/profile');
                } else {
                  ViewPost.postId = note.postId;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewPost(),
                    ),
                  );
                }
              },
              leading: _setIcon(note),
              trailing: Text(note.timePassed),
              title: Text(
                note.content,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                //textAlign: TextAlign,
              ),
              subtitle: Text('Novo obaveštenje')),
        ),
      ],
    );
  }

  Widget _setIcon(NotificationInfo note) {
    var icon;
    switch (note.type) {
      case postReactionChallenge:
        icon = Icons.star;
        break;
      case postReactionSolution:
        icon = FaIcon(
          FontAwesomeIcons.signLanguage,
          color: Colors.teal[700],
          size: 50.0,
        );
        break;
      case solutionForChallenge:
        icon = Icons.done_all;
        break;
      case commentLike:
        icon = Icons.thumb_up;
        break;
      case commentDislike:
        icon = Icons.thumb_down;
        break;
      case commentForPost:
        icon = Icons.comment;
        break;
      case followType:
        icon = Icons.person_add;
        break;
      case rank:
        icon = FaIcon(
          FontAwesomeIcons.solidGem,
          color: Colors.teal[700],
          size: 50.0,
        );
        break;
      default:
        icon = null;
    }
    if (note.type == postReactionSolution || note.type == rank) return icon;
    return Icon(
      icon,
      color: Colors.teal[700],
      size: 50.0,
    );
  }

  Widget buildBodyUnread(List<NotificationInfo> notificationListUnread) {
    return Container(
      //child: Text('Blaaa'),
      padding: EdgeInsets.all(15.0),
      //margin: EdgeInsets.only(top: 10.0),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          notificationListUnread.length != 0
              ? noteficationList(notificationListUnread)
              : Container(
                  child: Center(
                    child: Text('Nema novih obaveštenja!'),
                  ),
                )
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget yesButton = FlatButton(
      child: Text(
        "DA",
        style: TextStyle(
          color: Colors.teal[800],
          fontSize: 20.0,
          //fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () async {
        showDialog(context: context, builder: (context) => Loading());
        await APINotification.readAllNotifications(Token.jwt)
            //.then((value) => sendNotification(loginUserID))
            .then((value) => Navigator.of(context).pop());
        setState(() {
          BuildBodyUnread.notificationList = List<NotificationInfo>();
        });
        Navigator.of(context).pop();
      },
    );

    Widget noButton = FlatButton(
      child: Text(
        "NE",
        style: TextStyle(
          color: Colors.teal[800],
          fontSize: 20.0,
          //fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      content: Text(
        "Da li želite da prebacite sva obaveštenja u pročitana obaveštenja?",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.teal[800],
          fontSize: 20.0,
          //fontWeight: FontWeight.bold,
          //fontStyle: FontStyle.italic,
        ),
      ),
      actions: [
        yesButton,
        noButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //sendNotification(loginUserID);
    // for (var n in BuildBodyUnread.notificationList) {
    //   print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA ${n.content}');
    // }
    return Container(
      child: FutureBuilder(
        future: APINotification.getAllNotReadNotifications(Token.jwt),
        builder: (BuildContext context,
            AsyncSnapshot<List<NotificationInfo>> snapshot) {
          if (!snapshot.hasData || BuildBodyUnread.notificationList == null)
            return Center(child: Text(''));
          else
            return Container(
              child: buildBodyUnread(snapshot.data),
              //buildBodyUnread(BuildBodyUnread.notificationList),
            );
        },
      ),
    );
  }
}
