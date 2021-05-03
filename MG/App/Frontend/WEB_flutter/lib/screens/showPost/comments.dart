import 'package:WEB_flutter/config/config.dart';
import 'package:WEB_flutter/models/modelsViews/commentInfo.dart';
import 'package:WEB_flutter/screens/homePage/postsAndComments/expandedText.dart';
import 'package:WEB_flutter/services/APIComments.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ListCommentsByID extends StatefulWidget {
  static int id;

  @override
  _ListCommentsState createState() => _ListCommentsState();
}

class _ListCommentsState extends State<ListCommentsByID> {
  @override
  Widget build(BuildContext context) {
    APIComments.getAllCommentsByPostID(Token.jwt, ListCommentsByID.id);
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: APIComments.getAllCommentsByPostID(
              Token.jwt, ListCommentsByID.id),
          builder: (BuildContext context,
              AsyncSnapshot<List<CommentInfo>> snapshot) {
            if (snapshot.data == null) {
              return Center(
                  child: Container(
                      //child: Text('Nije dobro')),
                      child: SpinKitFadingCircle(
                color: Colors.white,
                size: 50.0,
              )));
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _contactList(snapshot.data[index]);
                    //return _contactList(snapshot.data[index], '');
                  });
            }
          },
        ),
      ),
    );
  }

  Widget _contactList(CommentInfo comment) {
    var nameInitial = comment.username[0].toUpperCase();
    if (comment.profilePhoto.length > 0) {
      //ako je prosledejena slika
      nameInitial = ""; //
    }

    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          backgroundImage: comment.profilePhoto.length > 0
              ? NetworkImage(wwwrootURL + comment.profilePhoto)
              : null,
          radius: 30,
          child: Text(
            nameInitial,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.grey[200]),
          ),
        ),
        title: Container(
          height: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(comment.username),
            ],
          ),
        ),
        subtitle: Container(
          padding: EdgeInsets.only(right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              ExpandedText(
                text: comment.content,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.thumb_up,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(comment.commentLikes.toString()),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.thumb_down,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(comment.commentDislikes.toString()),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
