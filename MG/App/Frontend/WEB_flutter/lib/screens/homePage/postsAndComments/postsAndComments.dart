import 'package:WEB_flutter/screens/showComments/listShowComments.dart';
import 'package:WEB_flutter/screens/showComments/showCommentsPage.dart';
import 'package:WEB_flutter/screens/showPost/showPostsPage/listShowPosts.dart';
import 'package:WEB_flutter/screens/showPost/showPostsPage/showPostsPage.dart';
import 'package:flutter/material.dart';
import 'package:WEB_flutter/screens/homePage/postsAndComments/listComments.dart';
import 'package:WEB_flutter/screens/homePage/postsAndComments/userImportantPosts.dart';
import 'package:WEB_flutter/screens/homePage/postsAndComments/userReportedPosts.dart';
import 'package:WEB_flutter/hover_extensions.dart';

int indTypePosts = 1; // 1 - reported, 2 - important
// Widget typePosts = UserReportedPosts();
// Widget typeComments = ListComments();

class PostsAndComments extends StatefulWidget {
  @override
  PostsAndCommentsState createState() => PostsAndCommentsState();
}

class PostsAndCommentsState extends State<PostsAndComments> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 900,
        child: Column(
          children: <Widget>[
            Expanded(
              child: _buildPosts(),
              flex: 9,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: _buildComments(),
              flex: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPosts() {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(24, 74, 69, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: <Widget>[
          _buildPostsBar(),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black38, width: 0.5),
              ),
            ),
          ),
          isPressed1 == true ? UserReportedPosts() : UserImportantPosts(),
          SizedBox(
            height: 10,
          ),
          FlatButton(
              color: Colors.grey[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              onPressed: () {
                setState(() {
                  ListShowPosts.filterIndex = isPressed1 == true ? 1 : 2;
                  ShowPostPageState.isPressed1 =
                      isPressed1 == true ? true : false;
                  ShowPostPageState.isPressed2 =
                      isPressed2 == true ? true : false;
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShowPostPage()));
              },
              child: Text(
                'Prikaži više',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              )).showPointerOnHover,
        ],
      ),
    );
  }

  Widget _buildComments() {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(24, 74, 69, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: <Widget>[
          _buildCommentsBar(),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black38, width: 0.5),
              ),
            ),
          ),
          ListComments(),
          FlatButton(
              color: Colors.grey[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              onPressed: () {
                setState(() {
                  //ListComments.approved = isPressedComm1 == true ? false : true;
                  ListShowComments.filterIndex = isPressedComm1== true ? 1 : 2;
                  ShowCommentsPageState.isPressed1 =
                      isPressedComm1 == true ? true : false;
                  ShowCommentsPageState.isPressed2 =
                      isPressedComm2 == true ? true : false;
                }); 
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowCommentsPage()));
              },
              child: Text(
                'Prikaži više',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              )).showPointerOnHover,
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  static bool isPressedComm1 = true;
  static bool isPressedComm2 = false;

  Widget _buildCommentsBar() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        //ne treba
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FlatButton(
            color: isPressedComm1 ? Colors.grey[200] : Colors.blueGrey[300],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            onPressed: () {
              setState(() {
                isPressedComm1 = true;
                isPressedComm2 = false;
                ListComments.approved = false;
                ListComments();
              });
            },
            child: Text(
              'Prijavljeni komentari',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isPressedComm1 ? Colors.black : Colors.blueGrey[800]),
            ),
          ).showPointerOnHover,
          FlatButton(
            color: isPressedComm2 ? Colors.grey[200] : Colors.blueGrey[300],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            onPressed: () {
              setState(() {
                isPressedComm1 = false;
                isPressedComm2 = true;
                ListComments.approved = true;
                ListComments();
              });
            },
            child: Text(
              'Odobreni komentari',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isPressedComm2 ? Colors.black : Colors.blueGrey[800]),
            ),
          ).showPointerOnHover,
        ],
      ),
    );
  }

  static bool isPressed1 = true;
  static bool isPressed2 = false;

  Widget _buildPostsBar() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FlatButton(
            color: isPressed1 ? Colors.grey[200] : Colors.blueGrey[300],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            onPressed: () {
              setState(() {
                isPressed1 = true;
                isPressed2 = false;
                UserReportedPosts();
              });
            },
            child: Text(
              'Prijavljene objave',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isPressed1 ? Colors.black : Colors.blueGrey[800]),
            ),
          ).showPointerOnHover,
          FlatButton(
            color: isPressed2 ? Colors.grey[200] : Colors.blueGrey[300],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            onPressed: () {
              setState(() {
                isPressed1 = false;
                isPressed2 = true;
                UserImportantPosts();
              });
            },
            child: Text(
              'Najvažnije objave',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isPressed2 ? Colors.black : Colors.blueGrey[800]),
            ),
          ).showPointerOnHover,
        ],
      ),
    );
  }
}
