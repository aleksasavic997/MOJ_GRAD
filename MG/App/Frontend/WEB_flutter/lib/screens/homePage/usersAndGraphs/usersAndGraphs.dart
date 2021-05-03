import 'package:WEB_flutter/main.dart';
import 'package:WEB_flutter/screens/homePage/home.dart';
import 'package:WEB_flutter/screens/homePage/postsAndComments/listComments.dart';
import 'package:WEB_flutter/screens/homePage/postsAndComments/postsAndComments.dart';
import 'package:WEB_flutter/screens/showUsers/listShowUsers.dart';
import 'package:WEB_flutter/screens/showUsers/showUsers.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:flutter/material.dart';
import 'package:WEB_flutter/screens/homePage/usersAndGraphs/dataGraphs.dart';
import 'package:WEB_flutter/screens/homePage/usersAndGraphs//listAllUsers.dart';
import 'package:WEB_flutter/screens/homePage/usersAndGraphs//listBestUsers.dart';
import 'package:WEB_flutter/screens/homePage/usersAndGraphs//listBlokcedUsers.dart';
import 'package:WEB_flutter/hover_extensions.dart';
import 'package:flutter/rendering.dart';

Widget graph = Graf1();
Widget typeUsers = ListAllUsers();

class UsersAndGraphs extends StatefulWidget {
  @override
  _UsersAndGraphsState createState() => _UsersAndGraphsState();
}

class _UsersAndGraphsState extends State<UsersAndGraphs> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 900,
        child: Column(
          children: <Widget>[
            Expanded(
              child: _buildUsers(),
              flex: 4,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: _buildGraphs(),
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsers() {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(24, 74, 69, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: <Widget>[
          _buildUsersBar(),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black38, width: 0.5),
              ),
            ),
          ),
          typeUsers,
          SizedBox(
            height: 10,
          ),
          FlatButton(
              color: Colors.grey[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              onPressed: () {
                ListShowUsers.filterIndex =
                    isPressed1 == true ? 1 : isPressed2 == true ? 2 : 3;
                ShowUsersState.isPressed1 = isPressed1 == true ? true : false;
                ShowUsersState.isPressed2 = isPressed2 == true ? true : false;
                ShowUsersState.isPressed3 = isPressed3 == true ? true : false;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShowUsers()));
              },
              child: Text(
                'Prikaži više',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              )).showPointerOnHover,
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  bool isPressed1 = true;
  bool isPressed2 = false;
  bool isPressed3 = false;

  Widget _allUsersButton(BoxConstraints constraints) {
    return FlatButton(
        color: (isPressed1 && idUserFilter == 0)
            ? Colors.grey[200]
            : Colors.blueGrey[300],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        onPressed: () {
          setState(() {
            isPressed1 = true;
            isPressed2 = false;
            isPressed3 = false;
            idUserFilter = 0; //zbog filtriranja
            PostsAndCommentsState.isPressed1 = true;
            PostsAndCommentsState.isPressed2 = false;
            PostsAndCommentsState.isPressedComm1 = true;
            PostsAndCommentsState.isPressedComm2 = false;
            ListComments.approved = false;
            typeUsers = ListAllUsers();
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage.fromBase64(Token.jwt),
            ),
          );
        },
        child: Text(
          constraints.maxWidth > 450 ? 'Svi korisnici' : 'Svi \nkorisnici',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: (isPressed1 && idUserFilter == 0)
                  ? Colors.black
                  : Colors.blueGrey[800]),
        )).showPointerOnHover;
  }

  Widget _reportedUsersButton(BoxConstraints constraints) {
    return FlatButton(
      color: isPressed2 ? Colors.grey[200] : Colors.blueGrey[300],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      onPressed: () {
        setState(() {
          isPressed1 = false;
          isPressed2 = true;
          isPressed3 = false;
          typeUsers = ListBlockedUsers();
        });
      },
      child: Text(
        constraints.maxWidth > 450
            ? 'Prijavljeni korisnici'
            : 'Prijavljeni \nkorisnici',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isPressed2 ? Colors.black : Colors.blueGrey[800]),
      ),
    ).showPointerOnHover;
  }

  Widget _bestUsersButton(BoxConstraints constraints) {
    return FlatButton(
      color: isPressed3 ? Colors.grey[200] : Colors.blueGrey[300],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      onPressed: () {
        setState(() {
          isPressed1 = false;
          isPressed2 = false;
          isPressed3 = true;
          typeUsers = ListBestUsers();
        });
      },
      child: Text(
        constraints.maxWidth > 450
            ? 'Najbolji korisnici'
            : 'Najbolji \nkorisnici',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isPressed3 ? Colors.black : Colors.blueGrey[800]),
      ),
    ).showPointerOnHover;
  }

  Widget _buildUsersBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 450) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _allUsersButton(constraints),
                _reportedUsersButton(constraints),
                _bestUsersButton(constraints),
              ],
            ),
          );
        } else {
          return Container(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _allUsersButton(constraints),
                _reportedUsersButton(constraints),
                _bestUsersButton(constraints),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildGraphs() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: <Widget>[
          _buildGraphBar(),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black38, width: 0.5),
              ),
            ),
          ),
          SizedBox(height: 300, child: graph) //ovo je widget
        ],
      ),
    );
  }

  Widget _buildGraphBar() {
    return Container(
      child: Row(
        children: <Widget>[
          RawMaterialButton(
            onPressed: () {
              if (!(graph is Graf1)) {
                setState(() {
                  graph = Graf1();
                });
              }
            },
            child: Icon(
              Icons.pie_chart,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
          ).showPointerOnHover,
          RawMaterialButton(
            onPressed: () {
              if (!(graph is Graf2)) {
                setState(() {
                  graph = Graf2();
                });
              }
            },
            child: Icon(
              Icons.insert_chart,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
          ).showPointerOnHover,
          RawMaterialButton(
            onPressed: () {
              if (!(graph is Graf3)) {
                setState(() {
                  graph = Graf3();
                });
              }
            },
            child: Icon(
              Icons.show_chart,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
          ).showPointerOnHover
        ],
      ),
    );
  }
}
