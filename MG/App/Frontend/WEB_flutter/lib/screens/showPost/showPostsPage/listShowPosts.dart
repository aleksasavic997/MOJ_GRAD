import 'package:WEB_flutter/main.dart';
import 'package:WEB_flutter/screens/showPost/showPostsPage/showPostsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../config/config.dart';
import '../../../models/modelsViews/postInfo.dart';
import '../../../services/APIPosts.dart';
import '../../../services/token.dart';
import '../showPost.dart';
import 'package:WEB_flutter/hover_extensions.dart';

class ListShowPosts extends StatefulWidget {
  static int filterIndex;
  @override
  _ListShowPostsState createState() => _ListShowPostsState();
}

class _ListShowPostsState extends State<ListShowPosts> {
  List<PostInfo> postList = new List<PostInfo>();
  List<PostInfo> filterPosts;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: FutureBuilder(
        future: _makeFuture(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PostInfo>> snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: Container(
                child: SpinKitFadingCircle(
                  color: Colors.white,
                  size: 50,
                ),
              ),
            );
          } else {
            postList = snapshot.data.toList();
            print("tu sam");
            return ShowPostPageState.firstSearch
                ? _listViewBuilder(snapshot.data.toList(), 1)
                : _search();
          }
        },
      )),
    );
  }

  Widget _search() {
    print("blaaaaaaaaaaaaaaa");
    filterPosts = new List<PostInfo>();
    for (int i = 0; i < postList.length; i++) {
      PostInfo item = postList[i];
      if (item.title
              .toLowerCase()
              .contains(ShowPostPageState.query.toLowerCase()) ||
          item.categoryName
              .toLowerCase()
              .contains(ShowPostPageState.query.toLowerCase())) {
        filterPosts.add(item);
      }
    }

    return _listViewBuilder(filterPosts, 0);
  }

  Widget _listViewBuilder(List<PostInfo> posts, int ind) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: MediaQuery.of(context).size.height * 0.85,
        child: LayoutBuilder(builder: (context, constraints) {
          return StaggeredGridView.count(
            crossAxisCount: constraints.maxWidth < 900
                ? (constraints.maxWidth < 600
                    ? (constraints.maxWidth < 400 ? 1 : 2)
                    : 3)
                : 4,
            children: List.generate(posts.length, (int index) {
              return _Tile(
                post: posts[index],
              );
            }),
            staggeredTiles: List.generate(posts.length, (int index) {
              return StaggeredTile.fit(1);
            }),
          );
        }),
      ),
    );
  }

  Future<List<PostInfo>> _makeFuture() {
    switch (ListShowPosts.filterIndex) {
      case 1:
        if (idUserFilter == 0)
          return APIPosts.getReportedPost(Token.jwt);
        else
          return APIPosts.getReportedPostByUserID(Token.jwt, idUserFilter);
        break;
      case 2:
        if (idUserFilter == 0)
          return APIPosts.getMostImportantPost(0, 0, Token.jwt);
        else
          return APIPosts.getMostImportantPostsByUserID(
              0, Token.jwt, idUserFilter);
        break;
    }
    return null;
  }
}

class _Tile extends StatelessWidget {
  final PostInfo post;

  const _Tile({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: RaisedButton(
        onPressed: () {
          ShowPost.post = post;
          Navigator.push(context,
              MaterialPageRoute<void>(builder: (context) => ShowPost()));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 300,
                      padding: EdgeInsets.only(top: 15),
                      child: ClipRect(
                        child: Image.network(
                          wwwrootURL + post.imagePath,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.description.length > 30
                        ? post.description.substring(0, 30) + '...'
                        : post.description),
                  )
                ],
              ),
            ),
          ],
        ),
      ).showPointerOnHover,
    );
  }
}
