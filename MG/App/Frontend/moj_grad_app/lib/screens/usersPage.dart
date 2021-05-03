import 'package:mojgradapp/screens/profilePage.dart';
import 'package:mojgradapp/services/APIFollow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mojgradapp/config/config.dart';
import 'package:mojgradapp/services/APIUsers.dart';
import 'package:mojgradapp/services/token.dart';
import 'package:mojgradapp/models/modelsViews/userInfo.dart';

import '../main.dart';

class UsersPage extends StatefulWidget {
  static int filterIndex;
  @override
  _MyUsersPageState createState() => _MyUsersPageState();
}

class _MyUsersPageState extends State<UsersPage> {
  String name;
  String lastname;

  TextEditingController _searchView = new TextEditingController();
  List<UserInfo> usersList = new List<UserInfo>();
  List<UserInfo> filterUsers;
  bool _firstSearch = true;
  String query = "";
  bool _searchActive = false;

  _MyUsersPageState() {
    _searchView.addListener(() {
      if (_searchView.text.isEmpty) {
        setState(() {
          _firstSearch = true;
          query = "";
        });
      } else {
        setState(() {
          _firstSearch = false;
          query = _searchView.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: _searchActive == false
            ? new AppBar(
                actions: [
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async {
                        setState(() {
                          _searchActive = true;
                        });
                      },
                    )
                  ],
                title: Text(
                  'Korisnici',
                  style: Theme.of(context).textTheme.title,
                ),
                centerTitle: true)
            : new AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      _searchActive = false;
                      query = "";
                    });
                  },
                ),
                title: //Expanded(
                    //width: 300,
                    TextField(
                  //expands: true,
                  style: TextStyle(color: Colors.white),
                  autofocus: true,
                  controller: _searchView,
                  decoration: InputDecoration(
                    hintText: "Pretrazi",
                    hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5), fontSize: 18),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                  cursorColor: Colors.white,
                  showCursor: true,
                ),
              ),
        //),
        body: _firstSearch ? _createListView() : _search());
  }

  Widget _search() {
    filterUsers = new List<UserInfo>();
    for (int i = 0; i < usersList.length; i++) {
      UserInfo item = usersList[i];
      if (item.username.toLowerCase().contains(query.toLowerCase()) ||
          item.fullName.toLowerCase().contains(query.toLowerCase()) ||
          item.fullLastName.toLowerCase().contains(query.toLowerCase())) {
        filterUsers.add(item);
      }
    }

    return _listViewBuilder(filterUsers, 0);
  }

  Widget _listViewBuilder(List<UserInfo> users, int ind) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          // setState(() {
          ind == 1 ? usersList = users.toList() : null;
          // });
          return ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(wwwrootURL + users[index].profilePhoto),
            ),
            title: Text(users[index].username),
            subtitle: Text(users[index].name + " " + users[index].lastname),
            trailing: _buildFollow(users[index].id),
            //buildRaisedButton(snapshot, index),
            onTap: () async {
              ProfilePage.user =
                  await APIUsers.getUserInfoById(users[index].id, Token.jwt);
              Navigator.of(context).pushNamed('/profile');
            },
          );
        });
  }

  Widget _createListView() {
    return Container(
      child: FutureBuilder(
          future: _makeFuture(), //APIServices.getAllUsers(Token.jwt),
          builder:
              (BuildContext context, AsyncSnapshot<List<UserInfo>> snapshot) {
            if (!snapshot.hasData) {
              print("ovde sam");
              return Container(
                child: Center(child: Text('Loading...')),
              );
            } else {
              return _listViewBuilder(snapshot.data.toList(), 1);
              // ListView.builder(
              //     itemCount: snapshot.data.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       //setState(() {
              //       usersList = snapshot.data.toList();
              //       //});
              //       return ListTile(
              //         leading: CircleAvatar(
              //           backgroundImage: NetworkImage(
              //               wwwrootURL + usersList[index].profilePhoto),
              //         ),
              //         title: Text(usersList[index].username),
              //         subtitle: Text(usersList[index].name +
              //             " " +
              //             usersList[index].lastname),
              //         trailing: _buildFollow(usersList[index].id),
              //         //buildRaisedButton(snapshot, index),
              //         onTap: () async {
              //           ProfilePage.user = await APIServices.getUserInfoById(
              //               usersList[index].id, Token.jwt);
              //           Navigator.of(context).pushNamed('/profile');
              //         },
              //       );
              //     });
            }
          }),
    );
  }

  showAlertDialogNeca(BuildContext context, int id) {
    // set up the button
    Widget yesButton = FlatButton(
      child: Text(
        "DA",
        style: TextStyle(
          color: Colors.teal[800],
          fontSize: 20.0,
          //fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        setState(() {
          APIFollow.addFollow(Token.jwt, id)
              .then((value) => sendNotification(id));
        });
        Navigator.of(context).pop();
        //UsersPage();
      },
    );
    Widget noButton = FlatButton(
      child: Text(
        "NE",
        style: TextStyle(
          color: Colors.teal[800],
          fontSize: 20.0,
          //fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("My title"),
      content: Text(
        "Da li želiš da prekineš praćenje?",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          //fontWeight: FontWeight.bold,
          //fontStyle: FontStyle.italic,
        ),
      ),
      backgroundColor: Colors.white, //Theme.of(context).primaryColor,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25)),
      actions: [
        yesButton,
        noButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  /*Widget buildRaisedButton(AsyncSnapshot<List<UserInfo>> snapshot, int index) {
    if (snapshot.data[index].id != loginUserID)
      return RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15.0),
        ),
        onPressed: () {

        },
        child: Text("Dodaj", style: TextStyle(color: Colors.white)),
        color: Theme.of(context).primaryColor,
      );
    else
      return null;
  }*/

  Widget _buildFollow(int id) {
    return FutureBuilder(
      future: APIFollow.checkIfFollow(Token.jwt, id),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData)
          return CircularProgressIndicator();
        else {
          String text;
          Icon icon;
          if (snapshot.data == true) {
            text = 'Praćenje';
            icon = Icon(
              Icons.group,
              color: Colors.white,
              size: 13.0,
            );
          } else {
            text = 'Zaprati';
            icon = Icon(
              Icons.person_add,
              color: Colors.white,
              size: 13.0,
            );
          }
          return Container(
            height: 35,
            child: FloatingActionButton.extended(
              heroTag: '$id',
              backgroundColor: Colors.teal[900],
              icon: icon,
              //shape: ,
              label: Text(
                text,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onPressed: () {
                if (snapshot.data == true) {
                  showAlertDialogNeca(context, id);
                } else {
                  setState(() {
                    APIFollow.addFollow(Token.jwt, id)
                        .then((value) => sendNotification(id));
                  });
                }
              },
            ),
          );
        }
      },
    );
  }

  Future<List<UserInfo>> _makeFuture() {
    switch (UsersPage.filterIndex) {
      case 0:
        return APIFollow.getFollowSugestions(Token.jwt);
        break;
      case 1:
        return APIFollow.getAllFollowersOfUser(Token.jwt);
        break;
      case 2:
        return APIFollow.getAllFollowingUsers(Token.jwt);
        break;
    }
    return null;
  }
}
