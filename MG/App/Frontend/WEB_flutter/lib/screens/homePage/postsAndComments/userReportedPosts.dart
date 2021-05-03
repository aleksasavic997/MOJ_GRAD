import 'package:WEB_flutter/config/config.dart';
import 'package:WEB_flutter/main.dart';
import 'package:WEB_flutter/models/modelsViews/postInfo.dart';
import 'package:WEB_flutter/screens/showPost/showPost.dart';
import 'package:WEB_flutter/services/APIPosts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:WEB_flutter/hover_extensions.dart';

class UserReportedPosts extends StatefulWidget {
  @override
  _UserReportedPostsState createState() => _UserReportedPostsState();
}

class _UserReportedPostsState extends State<UserReportedPosts> {
  Container myArticles(PostInfo post) {
    return Container(
      width: 160.0,
      child: Card(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: InkWell(
            onTap: () {
              ShowPost.post = post;
              Navigator.push(context,
                  MaterialPageRoute<void>(builder: (context) => ShowPost()));
            },
            child: Wrap(
              children: <Widget>[
                Image.network(
                  wwwrootURL + post.imagePath,
                  height: 170.0,
                  width: 150.0,
                  fit: BoxFit.cover,
                ),
                ListTile(
                  title: Text(post.title.length > 13
                      ? post.title.substring(0, 13) + '...'
                      : post.title),
                  subtitle: Text(post.description.length > 13
                      ? post.description.substring(0, 13) + '...'
                      : post.description),
                )
              ],
            ),
          ),
        ),
      ).showPointerOnHover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0)),
            //color: Colors.grey[100],
          ),
          //height: 260,
          child: FutureBuilder(
            future: _makeFuture(),
            builder:
                (BuildContext context, AsyncSnapshot<List<PostInfo>> snapshot) {
              if (snapshot.data == null) {
                return Center(
                    child: Container(
                        //child: Text('Nije dobro')),
                        child: SpinKitFadingCircle(
                  color: Colors.white,
                  size: 50.0,
                )));
              } else {
                return snapshot.data.length == 0
                    ? Center(
                        child: Container(
                            padding: EdgeInsets.only(top: 100),
                            height: 200,
                            child: Text(
                              "Nema prijavljenih objava ",
                              style: TextStyle(color: Colors.white),
                            )))
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return myArticles(snapshot.data[index]);
                        });
              }
            },
          )),
    );
  }

  Future<List<PostInfo>> _makeFuture() {
    if (idUserFilter == 0)
      return APIPosts.getReportedPost(Token.jwt);
    else
      return APIPosts.getReportedPostByUserID(Token.jwt, idUserFilter);
  }
}
