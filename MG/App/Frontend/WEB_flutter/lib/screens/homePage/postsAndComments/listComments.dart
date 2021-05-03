import 'package:WEB_flutter/config/config.dart';
import 'package:WEB_flutter/main.dart';
import 'package:WEB_flutter/services/APIComments.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:WEB_flutter/hover_extensions.dart';
import '../../../models/modelsViews/commentInfo.dart';

class ListComments extends StatefulWidget {
  static bool approved = false;
  @override
  _ListCommentsState createState() => _ListCommentsState();
}

class _ListCommentsState extends State<ListComments> {
  createAlertDialog(BuildContext context, int id, bool delete) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: delete == true
                ? Text('Da li želite trajno da izbrišete ovaj komentar?')
                : Text('Da li želite da odobrite ovaj komentar?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  setState(() {
                    if (delete == true)
                      APIComments.deleteCommentById(id, Token.jwt);
                    else
                      APIComments.dissmissCommentReports(Token.jwt, id);
                    Navigator.of(context).pop();
                  });
                },
                child: Text(
                  'Da',
                  style: TextStyle(color: Colors.black),
                ),
                color: Colors.grey[300],
              ).showPointerOnHover,
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Ne',
                  style: TextStyle(color: Colors.black),
                ),
                color: Colors.grey[300],
              ).showPointerOnHover
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: _makeFuture(),
          builder: (BuildContext context,
              AsyncSnapshot<List<CommentInfo>> snapshot) {
            if (snapshot.data == null) {
              return Center(
                  child: Container(
                      child: SpinKitFadingCircle(
                color: Colors.white,
                size: 50.0,
              )));
            } else if (snapshot.data.length == 0) {
              return Center(
                  child: Text('Trenutno nema komentara za prikaz.',
                      style: TextStyle(color: Colors.white)));
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var comment = snapshot.data[index];
                    var nameInitial = comment.username[0].toUpperCase();
                    if (comment.profilePhoto.length > 0) {
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
                        trailing: Wrap(
                          spacing: 10.0,
                          children: <Widget>[
                            ListComments.approved == false
                                ? IconButton(
                                    icon: Icon(Icons.check),
                                    iconSize: 30,
                                    onPressed: () {
                                      setState(() {
                                        createAlertDialog(
                                            context, comment.id, false);
                                      });
                                    },
                                  ).showPointerOnHover
                                : SizedBox(
                                    height: 0,
                                  ),
                            IconButton(
                              icon: Icon(Icons.clear),
                              iconSize: 30,
                              onPressed: () {
                                setState(() {
                                  createAlertDialog(context, comment.id, true);
                                });
                              },
                            ).showPointerOnHover,
                          ],
                        ),
                        title: Container(
                          height: 20,
                          child: Text(comment.username),
                        ),
                        subtitle: Container(
                          padding: EdgeInsets.only(right: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Text(comment.content),
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
                  });
            }
          },
        ),
      ),
    );
  }

  Future<List<CommentInfo>> _makeFuture() {
    if (ListComments.approved == true)
      return APIComments.getApprovedReportedComments(Token.jwt,idUserFilter);
    else
      return APIComments.getReportedComment(Token.jwt,idUserFilter);
  }
}
