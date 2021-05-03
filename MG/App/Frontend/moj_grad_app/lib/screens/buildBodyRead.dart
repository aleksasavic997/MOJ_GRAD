import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mojgradapp/models/modelsViews/notificationInfo.dart';
import 'package:mojgradapp/screens/posts/viewPostPage.dart';
import 'package:mojgradapp/screens/profilePage.dart';
import 'package:mojgradapp/services/APINotifications.dart';
import 'package:mojgradapp/services/APIUsers.dart';
import 'package:mojgradapp/services/token.dart';

//procitana obavestenja

class BuildBodyRead extends StatefulWidget {
  BuildBodyRead({Key key}) : super(key: key);
  @override
  BuildBodyReadState createState() => BuildBodyReadState();
}

class BuildBodyReadState extends State<BuildBodyRead> {
  static const int postReactionChallenge = 1;
  static const int postReactionSolution = 2;
  static const int solutionForChallenge = 3;
  static const int commentLike = 4;
  static const int commentDislike = 5;
  static const int commentForPost = 6;
  static const int followType = 7;
  static const int rank = 8;
  //List<String> notificationListUnread = ['lllllllllllllllll','jhjhdjshdsd'];

  Widget noteficationList(List<NotificationInfo> notificationListRead) {
    return SizedBox(
        child: ListView.separated(
          controller: new ScrollController(),
            shrinkWrap: true,
            itemCount: notificationListRead.length,
            itemBuilder: (context, index) {
              return _cardNotes(notificationListRead[index]);
            },
            separatorBuilder: (context, index) {
              return Divider();
            }));
  }

  Widget _cardNotes(note) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Card(
          child: ListTile(
              onTap: () async {
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
              //leading: CircleAvatar(backgroundColor: Colors.black38,),
              leading: _setIcon(note),
              trailing: Text(note.timePassed),
              title: Text(
                note.content,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                //textAlign: TextAlign,
              ),
              subtitle: Text('Pročitano obaveštenje')),
        ),
      ],
    );
  }

  Widget buildBodyRead(List<NotificationInfo> notificationListRead) {
    return Container(
        //child: Text('Blaaa'),
        padding: EdgeInsets.all(15.0),
        //margin: EdgeInsets.only(top: 10.0),
        child: Column(
    //crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      notificationListRead.length != 0
          ? noteficationList(notificationListRead)
          : Container(
              child: Center(
                child: Text('Nema novih obaveštenja!'),
              ),
            )
    ],
        ),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: APINotification.getAllReadNotifications(Token.jwt),
        builder: (BuildContext context,
            AsyncSnapshot<List<NotificationInfo>> snapshot) {
          if (!snapshot.hasData)
            return Center(child: Text(''));
          else
            return Container(
              child: SingleChildScrollView(child: buildBodyRead(snapshot.data)),
            );
        },
      ),
    );
  }
}
