import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mojgradapp/functions/loading.dart';
import 'package:mojgradapp/models/category.dart';
import 'package:mojgradapp/screens/homePage.dart';
import 'package:mojgradapp/screens/posts/postTile.dart';
import 'package:mojgradapp/services/APIPosts.dart';
import 'package:mojgradapp/services/token.dart';
import '../../main.dart';
import '../../models/modelsViews/postInfo.dart';

class ShowPosts extends StatefulWidget {
  static int filterIndex = 0;
  static int fromFollowers = 0;
  static int activeChallenge = 0;
  static int sortByReactions = 0;
  static int cityID = loginUser.cityId;
  static List<Category> categories = List<Category>();

  @override
  _ShowPostsState createState() => _ShowPostsState();
}

class _ShowPostsState extends State<ShowPosts> {
  List<PostInfo> postList = new List<PostInfo>();
  List<PostInfo> filterPosts;

  @override
  Widget build(BuildContext context) {
    return HomePageState.firstSearch
        ? Container(
            child: FutureBuilder(
                future: APIPosts.getFilteredPosts(
                    Token.jwt,
                    ShowPosts.cityID,
                    ShowPosts.fromFollowers,
                    ShowPosts.activeChallenge,
                    ShowPosts.sortByReactions,
                    ShowPosts.categories),
                builder: (BuildContext context,
                    AsyncSnapshot<List<PostInfo>> snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                        child: Container(
                      child: Loading(),
                    ));
                  } else if (snapshot.data.length == 0) {
                    return Center(
                      child: Text('Trenutno nema objava za prikaz.'),
                    );
                  } else {
                    return _listViewBuilder(snapshot.data.toList(), 1);
                  }
                }))
        : _search();
  }

  Widget _search() {
    filterPosts = new List<PostInfo>();
    for (int i = 0; i < postList.length; i++) {
      PostInfo item = postList[i];
      if (item.title
              .toLowerCase()
              .contains(HomePageState.query.toLowerCase()) ||
          item.categoryName
              .toLowerCase()
              .contains(HomePageState.query.toLowerCase())) {
        filterPosts.add(item);
      }
    }

    return _listViewBuilder(filterPosts, 0);
  }

  Widget _listViewBuilder(List<PostInfo> posts, int ind) {
    return Padding(
      padding: EdgeInsets.all(3.0),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: StaggeredGridView.count(
                crossAxisCount: 4,
                children: List.generate(posts.length, (int index) {
                  ind == 1 ? postList = posts.toList() : null;
                  return Tile(
                    postId: posts[index].id,
                  );
                }),
                staggeredTiles: List.generate(posts.length, (int index) {
                  return StaggeredTile.fit(2);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
