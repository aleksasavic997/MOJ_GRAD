import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mojgradapp/config/config.dart';
import 'package:mojgradapp/models/modelsViews/postInfo.dart';
import 'package:mojgradapp/screens/posts/postReview.dart';
import 'package:mojgradapp/services/APIPosts.dart';
import 'package:mojgradapp/services/token.dart';
import '../../main.dart';
import 'viewPostPage.dart';

class Tile extends StatefulWidget {
  final int postId;

  Tile({this.postId});

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  var dialog;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: APIPosts.getPostByID(widget.postId, Token.jwt),
      builder: (BuildContext context, AsyncSnapshot<PostInfo> snapshot) {
        if (!snapshot.hasData)
          return Text("");
        else
          return Container(
            padding: EdgeInsets.all(5), //razmak izmedju zelenih okvira
            child: GestureDetector(
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 5.0,
                color: Colors.grey[100], //za menjanje boje okvira posta/objave
                onPressed: () async {
                  var x =
                      await APIPosts.getPostByID(snapshot.data.id, Token.jwt);
                  if (x == null)
                    _showSnakBarMsg(context);

                  //print('index==$index');
                  else {
                    ViewPost.postId = snapshot.data.id;
                    ViewPost.ind = 1;
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (context) => ViewPost()));
                  }
                },
                padding: EdgeInsets.all(
                    5), //debljina okvira; razmak izmedji slike i okvira
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: Image.network(
                          wwwrootURL + snapshot.data.imagePath //SLIKA
                          ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            snapshot.data.title, //NASLOV
                            style:
                                TextStyle(color: Colors.black, fontSize: 17.0),
                          ),
                          makeRow(snapshot),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              onLongPressUp: () {
                print('KRAAAAAJ');
              },
              onLongPress: () {
                dialog = PostReview(post: snapshot.data);
                showDialog(context: context, builder: (context) => dialog);
              },
            ),
          );
      },
    );
  }

  Widget makeRow(AsyncSnapshot<PostInfo> snapshot) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _makeCircle(snapshot),
        Row(
          children: <Widget>[
            _makeIconButton(snapshot),
            SizedBox(
              width: 5,
            ),
            Text(snapshot.data.reactionsNumber.toString()),
          ],
        ),
      ],
    );
  }

  Widget _makeCircle(AsyncSnapshot<PostInfo> snapshot) {
    var color;
    if (snapshot.data.typeId == 1)
      color = Colors.yellow[900];
    else if (snapshot.data.typeId == 2)
      color = Colors.green;
    else
      color = Colors.red;
    return FaIcon(
      FontAwesomeIcons.circle,
      color: color,
      size: 15,
    );
  }

  Widget _makeIconButton(AsyncSnapshot<PostInfo> snapshot) {
    var color;

    if (snapshot.data.getIsReacted == true)
      color = Colors.yellow[600];
    else
      color = Colors.grey[500];

    if (snapshot.data.typeId == 2) {
      return InkWell(
        child: FaIcon(
          FontAwesomeIcons.signLanguage,
          color: color,
          size: 20,
        ),
        onTap: () async {
          var x = await APIPosts.postReaction(
              Token.jwt, snapshot.data.id, loginUserID);
          if (x == true)
            setState(() {
              // APIPosts.postReaction(Token.jwt, snapshot.data.id, loginUserID)
              //     .then((value) => sendNotification(snapshot.data.userId));
              sendNotification(snapshot.data.userId);
            });
          else
            _showSnakBarMsg(context);
        },
      );
    } else {
      return InkWell(
        child: Icon(
          Icons.star,
          color: color,
          size: 20,
        ),
        onTap: () async {
          var x = await APIPosts.postReaction(
              Token.jwt, snapshot.data.id, loginUserID);
          if (x == true)
            setState(() {
              // APIPosts.postReaction(Token.jwt, snapshot.data.id, loginUserID)
              //     .then((value) => sendNotification(snapshot.data.userId));
              sendNotification(snapshot.data.userId);
            });
          else
            _showSnakBarMsg(context);
        },
      );
    }
  }

  _showSnakBarMsg(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: RichText(
            text: TextSpan(
      text: 'Objava je verovatno obrisana.',
      style: TextStyle(color: Colors.grey[200]),
    ))));
  }
}
