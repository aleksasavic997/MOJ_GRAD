import 'package:WEB_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../config/config.dart';
import '../../models/modelsViews/commentInfo.dart';
import '../../services/APIComments.dart';
import '../../services/token.dart';
import 'package:WEB_flutter/hover_extensions.dart';

class ListShowComments extends StatefulWidget {
  static int filterIndex;
  @override
  _ListShowCommentsState createState() => _ListShowCommentsState();
}

class _ListShowCommentsState extends State<ListShowComments> {
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
    return Container(
      height: 700,
      padding: EdgeInsets.all(8),
      child: FutureBuilder(
        future: ListShowComments.filterIndex == 1
            ? APIComments.getReportedComment(Token.jwt,idUserFilter)
            : APIComments.getApprovedReportedComments(Token.jwt,idUserFilter),
        builder:
            (BuildContext context, AsyncSnapshot<List<CommentInfo>> snapshot) {
          if (snapshot.data == null) {
            return Center(
                child: Container(
                    child: SpinKitFadingCircle(
              color: Colors.white,
              size: 50.0,
            )));
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
                    margin: EdgeInsets.all(3.0),
                    //padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        backgroundImage: comment.profilePhoto.length > 0
                            ? NetworkImage(wwwrootURL + comment.profilePhoto)
                            : null,
                        radius: 20,
                        child: Text(
                          nameInitial,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.grey[200]),
                        ),
                      ),
                      trailing: Wrap(
                        spacing: 10.0,
                        children: <Widget>[
                          ListShowComments.filterIndex == 1
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
                              : SizedBox(height: 0,),
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
                        height: 15,
                        child: Text(comment.username),
                      ),
                      subtitle: Container(
                        //padding: EdgeInsets.only(right: 30),
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
                                    size: 10,
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
                                    size: 10,
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
    );
  }
}
