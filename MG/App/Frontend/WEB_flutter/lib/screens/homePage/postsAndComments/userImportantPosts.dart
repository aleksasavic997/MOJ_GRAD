import 'package:WEB_flutter/config/config.dart';
import 'package:WEB_flutter/main.dart';
import 'package:WEB_flutter/models/modelsViews/postInfo.dart';
import 'package:WEB_flutter/screens/showPost/showPost.dart';
import 'package:WEB_flutter/services/APIPosts.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:WEB_flutter/hover_extensions.dart';

class UserImportantPosts extends StatefulWidget {
  @override
  _UserImportantPostsState createState() => _UserImportantPostsState();
}

class _UserImportantPostsState extends State<UserImportantPosts> {
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
                      : post.title, style: TextStyle(fontSize: 15),),
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
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0)),
        //color: Colors.grey[100],
      ),
      height: 260,
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
                          "Nema najvažnijih objava ",
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
      ),
      /*ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          myArticles("assets/slike-prirode-za-desktop-757.jpg",
              "Heading1", "SubHeading1"),
          myArticles("assets/boat.jpg", "Heading2", "SubHeading2"),
          myArticles("assets/nadrealne-slike-roba-gonsalvesa4.jpg",
              "Heading3", "SubHeading3"),
          myArticles("assets/man-love-heart.jpeg", "Heading4",
              "SubHeading4"),
          myArticles("assets/298425_atila-sabo-cigota_ff.jpg",
              "Heading5", "SubHeading5"),
        ],
      ), */
    );
  }

  Future<List<PostInfo>> _makeFuture() {
    if (idUserFilter == 0)
      return APIPosts.getMostImportantPost(0, 0, Token.jwt);
    else {
      return APIPosts.getMostImportantPostsByUserID(0, Token.jwt, idUserFilter);
    }
  }
}
