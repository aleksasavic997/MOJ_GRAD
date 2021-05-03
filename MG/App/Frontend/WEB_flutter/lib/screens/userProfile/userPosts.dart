import 'package:WEB_flutter/config/config.dart';
import 'package:WEB_flutter/models/modelsViews/postInfo.dart';
import 'package:WEB_flutter/models/modelsViews/userInfo.dart';
import 'package:WEB_flutter/screens/showPost/showPost.dart';
import 'package:WEB_flutter/services/APIPosts.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:flutter/material.dart';
import 'package:WEB_flutter/hover_extensions.dart';

class UserPosts2 extends StatefulWidget {
  final UserInfo user;

  const UserPosts2({this.user});
  @override
  _UserPosts2State createState() => _UserPosts2State(user);
}

class _UserPosts2State extends State<UserPosts2> {
  UserInfo user;
  _UserPosts2State(UserInfo user) {
    this.user = user;
  }

  bool isPressed1 = true;
  bool isPressed2 = false;
  bool isPressed3 = false;
  int index = 1;

  Container myArticles(PostInfo post) {
    return Container(
      width: 160.0,
      child: Card(
        color: Color.fromRGBO(24, 74, 69, 1),
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
                  height: 150.0,
                  width: 150.0,
                  fit: BoxFit.cover,
                ),
                ListTile(
                  title: Text(
                    post.title.length > 11
                        ? post.title.substring(0, 11) + '...'
                        : post.title,
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                      post.description.length > 11
                          ? post.description.substring(0, 11) + '...'
                          : post.description,
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ).showPointerOnHover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                    color: Color.fromRGBO(24, 74, 69, 1),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      'Izazovi',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
                color: Colors.grey[200],
              ),
              height: 280,
              child: _buildPosts()
              // FutureBuilder(
              //   future: APIPosts.getAllPostsByUserID(
              //       Token.jwt, user.id),
              //   builder: (BuildContext context,
              //       AsyncSnapshot<List<PostInfo>> snapshot) {
              //     if (snapshot.data == null) {
              //       return Center(
              //           child: Container(
              //               //child: Text('Nije dobro')),
              //               child: SpinKitFadingCircle(
              //         color: Colors.white,
              //         size: 50.0,
              //       )));
              //     } else {
              //       return ListView.builder(
              //           scrollDirection: Axis.horizontal,
              //           itemCount: snapshot.data.length,
              //           itemBuilder: (BuildContext context, int index) {
              //             return myArticles(snapshot.data[index]);
              //           });
              //     }
              //   },
              // ),
              ),
        ],
      ),
    );
  }

  Widget _buildPosts() {
    return Container(
      //margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          //color: Color.fromRGBO(24, 74, 69, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: <Widget>[
          _buildPostsBar(),
          Container(
            //padding: EdgeInsets.all(10.0),
            //margin: EdgeInsets.symmetric(vertical: 10.0),
            height: 220,
            child: FutureBuilder(
                future:
                    APIPosts.getPostsFilteredByType(user.id, index, Token.jwt),
                builder: (BuildContext context,
                    AsyncSnapshot<List<PostInfo>> snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  else if(snapshot.data.length == 0){
                    return Center(
                      child: Text('Trenutno nema objava za prikaz.'),
                    );
                  }
                  else {
                    //print(snapshot.data[index].title);
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return myArticles(snapshot.data[index]);
                          // return myArticles(
                          //     wwwrootURL + snapshot.data[index].imagePath,
                          //     snapshot.data[index].title,
                          //     snapshot.data[index].title,
                          //     snapshot.data[index].id);
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsBar() {
    return Container(
      //padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FlatButton(
            color: isPressed1 ? Colors.teal[800] : Colors.blueGrey[300],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            onPressed: () {
              setState(() {
                isPressed1 = true;
                isPressed2 = false;
                isPressed3 = false;
                index = 1;
              });
            },
            child: Text(
              'Aktivni',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isPressed1 ? Colors.white : Colors.blueGrey[800]),
            ),
          ).showPointerOnHover,
          FlatButton(
            color: isPressed2 ? Colors.teal[800] : Colors.blueGrey[300],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            onPressed: () {
              setState(() {
                isPressed1 = false;
                isPressed2 = true;
                isPressed3 = false;
                index = 2;
              });
            },
            child: Text(
              'Rešeni',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isPressed2 ? Colors.white : Colors.blueGrey[800]),
            ),
          ).showPointerOnHover,
          FlatButton(
            color: isPressed3 ? Colors.teal[800] : Colors.blueGrey[300],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            onPressed: () {
              setState(() {
                isPressed1 = false;
                isPressed2 = false;
                isPressed3 = true;
                index = 3;
              });
            },
            child: Text(
              'Završeni',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isPressed3 ? Colors.white : Colors.blueGrey[800]),
            ),
          ).showPointerOnHover,
        ],
      ),
    );
  }
}
